import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../../l10n/app_localizations.dart';

class FoodLoggingScreen extends StatefulWidget {
  const FoodLoggingScreen({super.key});

  @override
  State<FoodLoggingScreen> createState() => _FoodLoggingScreenState();
}

class _FoodLoggingScreenState extends State<FoodLoggingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  String? _mealCategory;

  final List<String> _mealCategories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Other',
  ];

  late final Box _logsBox;
  late final Box _surveyBox;
  String _preferredRegion = 'Other';
  bool _isManualMode = false;

  List<Map<String, dynamic>> _allFoods = [];
  List<Map<String, dynamic>> _filteredFoods = [];
  final _searchController = TextEditingController();
  String _selectedCategoryFilter = 'All';
  String _selectedRegionFilter = 'All';

  @override
  void initState() {
    super.initState();
    _logsBox = Hive.box('foodLogs');
    _surveyBox = Hive.box('surveyBox');
    _loadPreferences();
    _loadFoods();
    _searchController.addListener(_filterFoods);
  }

  void _loadPreferences() {
    _preferredRegion = _surveyBox.get('region', defaultValue: 'Other');
    _isManualMode = _surveyBox.get('manual_mode', defaultValue: false) &&
        !_surveyBox.get('completed', defaultValue: false);

    setState(() {
      _selectedRegionFilter = _isManualMode ? 'All' : _preferredRegion;
    });
  }

  Future<void> _loadFoods() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/foods.json');
    final List<dynamic> data = json.decode(jsonString);
    _allFoods = data.cast<Map<String, dynamic>>();
    _filterFoods();
  }

  void _filterFoods() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredFoods = _allFoods.where((food) {
        final name = (food['name'] as String).toLowerCase();
        final category = (food['category'] as String).toLowerCase();
        final region = (food['region'] as String).toLowerCase();

        final matchesSearch = name.contains(query);
        final matchesCategory = _selectedCategoryFilter == 'All' ||
            category == _selectedCategoryFilter.toLowerCase();
        final matchesRegion = _selectedRegionFilter == 'All' ||
            region == _selectedRegionFilter.toLowerCase() ||
            region == 'global';

        return matchesSearch && matchesCategory && matchesRegion;
      }).toList();
    });
  }

  Future<void> _addFood() async {
    if (_formKey.currentState!.validate()) {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final log = {
        'date': today,
        'foodName': _foodNameController.text.trim(),
        'calories': double.tryParse(_caloriesController.text) ?? 0.0,
        'quantity': double.tryParse(_quantityController.text) ?? 1.0,
        'mealCategory': _mealCategory ?? 'Other',
        'timestamp': DateTime.now().toIso8601String(),
      };

      final key = DateTime.now().millisecondsSinceEpoch.toString();
      await _logsBox.put(key, log);

      _foodNameController.clear();
      _caloriesController.clear();
      _quantityController.text = '1';
      setState(() => _mealCategory = null);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.foodAdded)),
        );
      }
    }
  }

  double _getTodayTotalCalories() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    double total = 0.0;

    for (var entry in _logsBox.values) {
      if (entry is Map && entry['date'] == today) {
        final cal = (entry['calories'] as num? ?? 0.0) *
            (entry['quantity'] as num? ?? 1.0);
        total += cal;
      }
    }
    return total;
  }

  double _getDailyTarget() {
    final box = Hive.box('surveyBox');
    final int age = box.get('age', defaultValue: 30);
    final String gender = box.get('gender', defaultValue: 'Other');
    final double heightCm = box.get('heightCm', defaultValue: 170.0);
    final double weightKg = box.get('weightKg', defaultValue: 70.0);
    final String activity = box.get('activityLevel', defaultValue: 'Sedentary');
    final String goal = box.get('goal', defaultValue: 'Maintain weight');

    double bmr = 10 * weightKg + 6.25 * heightCm - 5 * age;
    switch (gender.toLowerCase()) {
      case 'male':
        bmr += 5;
        break;
      case 'female':
        bmr -= 161;
        break;
      default:
        bmr -= 78;
    }

    double multiplier = 1.2;
    switch (activity) {
      case 'Sedentary (little or no exercise)':
        multiplier = 1.2;
        break;
      case 'Lightly active (light exercise/sports 1-3 days/week)':
        multiplier = 1.375;
        break;
      case 'Moderately active (moderate exercise/sports 3-5 days/week)':
        multiplier = 1.55;
        break;
      case 'Very active (hard exercise/sports 6-7 days/week)':
        multiplier = 1.725;
        break;
      case 'Super active (very hard exercise & physical job)':
        multiplier = 1.9;
        break;
    }

    double tdee = bmr * multiplier;
    switch (goal) {
      case 'Lose weight':
        tdee -= 500;
        break;
      case 'Gain muscle':
        tdee += 300;
        break;
    }
    return tdee.clamp(1200.0, 4000.0);
  }

  bool _hadLogsYesterday() {
    final yesterday = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 1)));
    for (var entry in _logsBox.values) {
      if (entry is Map && entry['date'] == yesterday) {
        return true;
      }
    }
    return false;
  }

  void _autoFillFood(String name, double calories) {
    _foodNameController.text = name;
    _caloriesController.text = calories.toStringAsFixed(0);
    _quantityController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final bool showTopBar = !_isManualMode;
    final todayCalories = _getTodayTotalCalories();
    final dailyTarget = showTopBar ? _getDailyTarget() : 0.0;
    final remainingCalories = dailyTarget - todayCalories;

    final showNewDayMessage =
        showTopBar && todayCalories == 0 && _hadLogsYesterday();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.logFood),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              if (showTopBar) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.3),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.today(todayCalories.toStringAsFixed(0)),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.remaining(remainingCalories.toStringAsFixed(0)),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              remainingCalories > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showNewDayMessage)
                  Container(
                    width: double.infinity,
                    color: Colors.blue.shade50,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      l10n.newDayMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.commonFoods,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: l10n.searchFoods,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ChoiceChip(
                                label: Text(l10n.all),
                                selected: _selectedCategoryFilter == 'All',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedCategoryFilter = 'All');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.breakfast),
                                selected:
                                    _selectedCategoryFilter == 'Breakfast',
                                onSelected: (_) {
                                  setState(() =>
                                      _selectedCategoryFilter = 'Breakfast');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.lunch),
                                selected: _selectedCategoryFilter == 'Lunch',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedCategoryFilter = 'Lunch');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.dinner),
                                selected: _selectedCategoryFilter == 'Dinner',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedCategoryFilter = 'Dinner');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.snack),
                                selected: _selectedCategoryFilter == 'Snack',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedCategoryFilter = 'Snack');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.fruit),
                                selected: _selectedCategoryFilter == 'Fruit',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedCategoryFilter = 'Fruit');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.dessert),
                                selected: _selectedCategoryFilter == 'Dessert',
                                onSelected: (_) {
                                  setState(() =>
                                      _selectedCategoryFilter = 'Dessert');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.drink),
                                selected: _selectedCategoryFilter == 'Drink',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedCategoryFilter = 'Drink');
                                  _filterFoods();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ChoiceChip(
                                label: Text(l10n.allRegions),
                                selected: _selectedRegionFilter == 'All',
                                onSelected: (_) {
                                  setState(() => _selectedRegionFilter = 'All');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.pakistan),
                                selected: _selectedRegionFilter == 'Pakistan',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedRegionFilter = 'Pakistan');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.india),
                                selected: _selectedRegionFilter == 'India',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedRegionFilter = 'India');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.saudiArabia),
                                selected:
                                    _selectedRegionFilter == 'Saudi Arabia',
                                onSelected: (_) {
                                  setState(() =>
                                      _selectedRegionFilter = 'Saudi Arabia');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.uae),
                                selected: _selectedRegionFilter ==
                                    'United Arab Emirates',
                                onSelected: (_) {
                                  setState(() => _selectedRegionFilter =
                                      'United Arab Emirates');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.usa),
                                selected:
                                    _selectedRegionFilter == 'United States',
                                onSelected: (_) {
                                  setState(() =>
                                      _selectedRegionFilter = 'United States');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.uk),
                                selected:
                                    _selectedRegionFilter == 'United Kingdom',
                                onSelected: (_) {
                                  setState(() =>
                                      _selectedRegionFilter = 'United Kingdom');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.germany),
                                selected: _selectedRegionFilter == 'Germany',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedRegionFilter = 'Germany');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.france),
                                selected: _selectedRegionFilter == 'France',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedRegionFilter = 'France');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.spain),
                                selected: _selectedRegionFilter == 'Spain',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedRegionFilter = 'Spain');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.indonesia),
                                selected: _selectedRegionFilter == 'Indonesia',
                                onSelected: (_) {
                                  setState(() =>
                                      _selectedRegionFilter = 'Indonesia');
                                  _filterFoods();
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: Text(l10n.turkey),
                                selected: _selectedRegionFilter == 'Turkey',
                                onSelected: (_) {
                                  setState(
                                      () => _selectedRegionFilter = 'Turkey');
                                  _filterFoods();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: _filteredFoods.length,
                          itemBuilder: (context, index) {
                            final food = _filteredFoods[index];
                            return ActionChip(
                              label: Text(
                                '${food['name']} (${food['calories']} ${l10n.kcal})',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              onPressed: () => _autoFillFood(
                                  food['name'], food['calories'].toDouble()),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _foodNameController,
                                decoration: InputDecoration(
                                  labelText: l10n.foodName,
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (v) => (v?.trim().isEmpty ?? true)
                                    ? l10n.required
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _caloriesController,
                                      decoration: InputDecoration(
                                        labelText: l10n.caloriesPerServing,
                                        border: const OutlineInputBorder(),
                                        helperText: l10n.caloriesHelper,
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return l10n.required;
                                        }
                                        final n = double.tryParse(v);
                                        if (n == null || n <= 0) {
                                          return l10n.positiveNumber;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _quantityController,
                                      decoration: InputDecoration(
                                        labelText: l10n.quantity,
                                        border: const OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return l10n.required;
                                        }
                                        final n = double.tryParse(v);
                                        if (n == null || n <= 0) {
                                          return l10n.positive;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String>(
                                initialValue: _mealCategory,
                                decoration: InputDecoration(
                                  labelText: l10n.mealCategory,
                                  border: const OutlineInputBorder(),
                                ),
                                items: _mealCategories
                                    .map((c) => DropdownMenuItem(
                                        value: c, child: Text(c)))
                                    .toList(),
                                onChanged: (v) =>
                                    setState(() => _mealCategory = v),
                                validator: (v) =>
                                    v == null ? l10n.required : null,
                              ),
                              const SizedBox(height: 32),
                              FilledButton.icon(
                                icon: const Icon(Icons.add),
                                label: Text(l10n.addFood),
                                style: FilledButton.styleFrom(
                                    minimumSize: const Size.fromHeight(56)),
                                onPressed: _addFood,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),
                        Text(l10n.loggedToday,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 8),
                        ValueListenableBuilder<Box>(
                          valueListenable: _logsBox.listenable(),
                          builder: (context, box, _) {
                            final today =
                                DateFormat('yyyy-MM-dd').format(DateTime.now());
                            final todayLogs = box.values
                                .where(
                                    (log) => log is Map && log['date'] == today)
                                .toList();

                            if (todayLogs.isEmpty) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 32),
                                child: Center(child: Text(l10n.noFoodToday)),
                              );
                            }

                            final grouped = <String, List<Map>>{};
                            for (var log in todayLogs) {
                              final cat =
                                  log['mealCategory'] as String? ?? 'Other';
                              grouped.putIfAbsent(cat, () => []).add(log);
                            }

                            final orderedCats = [
                              'Breakfast',
                              'Lunch',
                              'Dinner',
                              'Snack',
                              'Other'
                            ].where((c) => grouped.containsKey(c)).toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: orderedCats.map((cat) {
                                final items = grouped[cat]!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 16, 0, 8),
                                      child: Text(
                                        cat,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                    ),
                                    ...items.map((log) {
                                      final cal =
                                          (log['calories'] as num? ?? 0) *
                                              (log['quantity'] as num? ?? 1);
                                      return Dismissible(
                                        key: Key(log['timestamp'] ??
                                            log.hashCode.toString()),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: const Icon(Icons.delete,
                                              color: Colors.white),
                                        ),
                                        onDismissed: (direction) {
                                          box.delete(log.keys.first);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text(l10n.entryDeleted)),
                                            );
                                          }
                                        },
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0, vertical: 4),
                                          title: Text(
                                            log['foodName'] ?? l10n.unknown,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            '${log['quantity']} × ${log['calories']} ${l10n.kcal}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: Text(
                                            '${cal.toStringAsFixed(0)} ${l10n.kcal}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/'),
        label: Text(l10n.done),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _caloriesController.dispose();
    _quantityController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
