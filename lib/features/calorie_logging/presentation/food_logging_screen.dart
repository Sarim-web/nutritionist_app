import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

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

  // For today's logs
  late final Box _logsBox;

  @override
  void initState() {
    super.initState();
    _logsBox = Hive.box('foodLogs'); // now safe, already opened
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

      // Simple key: use timestamp as unique id
      final key = DateTime.now().millisecondsSinceEpoch.toString();
      await _logsBox.put(key, log);

      _foodNameController.clear();
      _caloriesController.clear();
      _quantityController.text = '1';
      setState(() => _mealCategory = null);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Food added!')));
    }
  }

  double _getTodayTotalCalories() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    double total = 0.0;

    for (var entry in _logsBox.values) {
      if (entry['date'] == today) {
        final cal =
            (entry['calories'] as num? ?? 0.0) *
            (entry['quantity'] as num? ?? 1.0);
        total += cal;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final todayCalories = _getTodayTotalCalories();

    return Scaffold(
      appBar: AppBar(title: const Text('Log Food'), centerTitle: true),
      body: Column(
        children: [
          // Today's summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today: ${todayCalories.toStringAsFixed(0)} kcal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // You can add target comparison here later
                Text(
                  'Remaining: ? kcal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _foodNameController,
                      decoration: const InputDecoration(
                        labelText: 'Food Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          (v?.trim().isEmpty ?? true) ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _caloriesController,
                            decoration: const InputDecoration(
                              labelText: 'Calories (per serving)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              final n = double.tryParse(v);
                              if (n == null || n <= 0) return 'Positive number';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _quantityController,
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              final n = double.tryParse(v);
                              if (n == null || n <= 0) return 'Positive';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: _mealCategory,
                      decoration: const InputDecoration(
                        labelText: 'Meal Category',
                        border: OutlineInputBorder(),
                      ),
                      items: _mealCategories
                          .map(
                            (c) => DropdownMenuItem(value: c, child: Text(c)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _mealCategory = v),
                      validator: (v) => v == null ? 'Required' : null,
                    ),
                    const SizedBox(height: 32),

                    FilledButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Food'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      onPressed: _addFood,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Today's logs list (simple for now)
          Divider(),
          Expanded(
            child: ValueListenableBuilder<Box>(
              valueListenable: _logsBox.listenable(),
              builder: (context, box, _) {
                final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
                final todayLogs = box.values
                    .where((log) => log['date'] == today)
                    .toList();

                if (todayLogs.isEmpty) {
                  return const Center(child: Text('No food logged today yet'));
                }

                return ListView.builder(
                  itemCount: todayLogs.length,
                  itemBuilder: (context, index) {
                    final log = todayLogs[index];
                    final cal =
                        (log['calories'] as num? ?? 0) *
                        (log['quantity'] as num? ?? 1);
                    return ListTile(
                      title: Text(log['foodName'] ?? 'Unknown'),
                      subtitle: Text(
                        '${log['quantity']} × ${log['calories']} kcal • ${log['mealCategory']}',
                      ),
                      trailing: Text(
                        '${cal.toStringAsFixed(0)} kcal',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onLongPress: () {
                        // Simple delete confirmation
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete entry?'),
                            content: const Text('This cannot be undone.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  box.delete(log.key);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
