import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/providers/profile_provider.dart';

class DietBuilderScreen extends StatefulWidget {
  const DietBuilderScreen({super.key});

  @override
  State<DietBuilderScreen> createState() => _DietBuilderScreenState();
}

class _DietBuilderScreenState extends State<DietBuilderScreen> {
  late Box _surveyBox;
  String _selectedMealType = 'Breakfast'; // Selected meal for planning
  double _targetCalories = 0;
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final profileProvider = context.read<ProfileProvider>();
    _surveyBox = profileProvider.surveyBox;

    final survey = _surveyBox.get('survey_data');
    if (survey != null) {
      setState(() {
        // Calculate daily target from survey data
        _targetCalories = (survey['daily_target'] as num? ?? 2000).toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Builder'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            if (context.mounted) {
              context.go('/');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Target Summary
            _buildDailySummary(context),
            const SizedBox(height: 24),

            // Meal Type Selector
            Text(
              'Plan Your Meal',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildMealTypeSelector(context),
            const SizedBox(height: 24),

            // Recommendations for selected meal
            _buildMealRecommendations(context),
            const SizedBox(height: 24),

            // Quick Add Suggestions
            _buildQuickAddSuggestions(context),
            const SizedBox(height: 24),

            // Meal Builder Form
            _buildMealBuilderForm(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDailySummary(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Target',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Goal',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_targetCalories.toStringAsFixed(0)} kcal',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.local_fire_department,
                    size: 32,
                    color: Colors.orange[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              minHeight: 8,
              value:
                  0.4, // Placeholder - would be (consumedCalories / targetCalories)
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text(
              'Remaining: 1200 kcal',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTypeSelector(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _mealTypes.map((meal) {
          final isSelected = _selectedMealType == meal;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(meal),
              selected: isSelected,
              onSelected: (value) {
                setState(() {
                  _selectedMealType = meal;
                });
              },
              showCheckmark: false,
              backgroundColor: Colors.grey[200],
              selectedColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.grey[800],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMealRecommendations(BuildContext context) {
    final recommendations = {
      'Breakfast': '400-500 kcal - Include protein & whole grains',
      'Lunch': '600-700 kcal - Balanced with vegetables',
      'Dinner': '500-600 kcal - Light and nutritious',
      'Snack': '100-150 kcal - Healthy options only',
    };

    return Card(
      elevation: 1,
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: Colors.blue[700],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommendation for $_selectedMealType',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recommendations[_selectedMealType] ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue[800],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAddSuggestions(BuildContext context) {
    final suggestions = {
      'Breakfast': [
        'Oatmeal with banana',
        'Eggs & toast',
        'Greek yogurt & berries'
      ],
      'Lunch': [
        'Grilled chicken & rice',
        'Salmon with vegetables',
        'Turkey sandwich'
      ],
      'Dinner': [
        'Lean beef & potatoes',
        'Fish & asparagus',
        'Pasta with tomato sauce'
      ],
      'Snack': ['Apple', 'Almonds', 'Greek yogurt'],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Suggestions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: (suggestions[_selectedMealType] ?? []).map((suggestion) {
            return ActionChip(
              label: Text(suggestion),
              avatar: const Icon(Icons.add, size: 18),
              onPressed: () {
                _showSnackBar('Added "$suggestion" to $_selectedMealType');
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMealBuilderForm(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Meal Builder',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search or enter food name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Calories',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Servings',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.add),
                label: Text('Add to $_selectedMealType'),
                onPressed: () {
                  _showSnackBar('Meal added to $_selectedMealType');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
