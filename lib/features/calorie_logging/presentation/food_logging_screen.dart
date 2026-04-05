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

  late Box _logsBox;
  late Box _surveyBox;
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
    final settingsBox = Hive.box('settings');
    final currentId =
        settingsBox.get('current_profile_id', defaultValue: 'main');
    _logsBox = Hive.box('foodLogs_$currentId');
    _surveyBox = Hive.box('survey_$currentId');
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
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/foods.json');
      final List<dynamic> data = json.decode(jsonString);
      _allFoods = data.cast<Map<String, dynamic>>();
      _filterFoods();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to load foods.json — check file in assets/data')),
        );
      }
      debugPrint('Error loading foods.json: $e');
    }
  }

  void _filterFoods() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredFoods = _allFoods.where((food) {
        final name = (food['name'] as String?)?.toLowerCase() ?? '';
        final category = (food['category'] as String?)?.toLowerCase() ?? '';
        final region = (food['region'] as String?)?.toLowerCase() ?? '';

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
    if (!_formKey.currentState!.validate()) return;

    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final log = {
        'date': today,
        'foodName': _foodNameController.text.trim(),
        'calories': double.tryParse(_caloriesController.text) ?? 0.0,
        'quantity': double.tryParse(_quantityController.text) ?? 1.0,
        'mealCategory': _mealCategory ?? 'Other',
        'timestamp': DateTime.now().toIso8601String(),
      };

      await _logsBox.add(log);

      _foodNameController.clear();
      _caloriesController.clear();
      _quantityController.text = '1';
      setState(() => _mealCategory = null);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.foodLogged)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to log food: ${e.toString()}')),
        );
      }
    }
  }

  void _autoFillFood(String name, double calories) {
    _foodNameController.text = name;
    _caloriesController.text = calories.toStringAsFixed(0);
    _quantityController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final bool completed = _surveyBox.get('completed', defaultValue: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.logFood),
        centerTitle: true,
        leading: BackButton(onPressed: () {
          if (context.mounted) context.go('/');
        }),
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: _logsBox.listenable(),
        builder: (context, box, _) {
          final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          final todayLogs = box.values
              .where((entry) => (entry as Map)['date'] == today)
              .toList();

          if (!completed) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        size: 80, color: Colors.orange),
                    const SizedBox(height: 24),
                    Text(l10n.takeSurveyDesc, textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    FilledButton.icon(
                      icon: const Icon(Icons.assessment),
                      label: Text(l10n.takeSurvey),
                      onPressed: () => context.go('/survey'),
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: l10n.searchFoods,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Category filters - Wrap to avoid overflow
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(l10n.all),
                        selected: _selectedCategoryFilter == 'All',
                        onSelected: (_) {
                          setState(() => _selectedCategoryFilter = 'All');
                          _filterFoods();
                        },
                      ),
                      ..._mealCategories.map((cat) => ChoiceChip(
                            label: Text(cat),
                            selected: _selectedCategoryFilter == cat,
                            onSelected: (_) {
                              setState(() => _selectedCategoryFilter = cat);
                              _filterFoods();
                            },
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Region filters - Wrap to avoid overflow
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(l10n.allRegions),
                        selected: _selectedRegionFilter == 'All',
                        onSelected: (_) {
                          setState(() => _selectedRegionFilter = 'All');
                          _filterFoods();
                        },
                      ),
                      ...[
                        'Pakistan',
                        'India',
                        'Saudi Arabia',
                        'UAE',
                        'USA',
                        'UK',
                        'Germany',
                        'France',
                        'Spain',
                        'Indonesia',
                        'Turkey'
                      ].map(
                        (r) => ChoiceChip(
                          label: Text(r),
                          selected: _selectedRegionFilter == r,
                          onSelected: (_) {
                            setState(() => _selectedRegionFilter = r);
                            _filterFoods();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Foods Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount =
                          (constraints.maxWidth / 180).floor().clamp(1, 4);

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _filteredFoods.length,
                        itemBuilder: (context, index) {
                          final food = _filteredFoods[index];
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () => _autoFillFood(
                                  food['name'], food['calories'].toDouble()),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      food['name'],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${food['calories']} kcal',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  if (_filteredFoods.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.no_food,
                                size: 80, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No matching foods found',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try changing filters or search term',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Manual Entry
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.manualEntry,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _foodNameController,
                          decoration: InputDecoration(
                            labelText: l10n.foodName,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (v) =>
                              v?.trim().isEmpty ?? true ? l10n.required : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _caloriesController,
                                decoration: InputDecoration(
                                  labelText: l10n.caloriesPerServing,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (v) {
                                  if (v?.isEmpty ?? true) return l10n.required;
                                  final n = double.tryParse(v!);
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
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (v) {
                                  if (v?.isEmpty ?? true) return l10n.required;
                                  final n = double.tryParse(v!);
                                  if (n == null || n <= 0) return l10n.positive;
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: l10n.mealCategory,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          initialValue: _mealCategory,
                          items: _mealCategories
                              .map((c) =>
                                  DropdownMenuItem(value: c, child: Text(c)))
                              .toList(),
                          onChanged: (v) => setState(() => _mealCategory = v),
                          validator: (v) => v == null ? l10n.required : null,
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          icon: const Icon(Icons.add),
                          label: Text(l10n.addFood),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _addFood,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
