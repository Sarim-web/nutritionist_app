import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box('surveyBox').listenable(),
        builder: (context, box, _) {
          final bool surveyCompleted = box.get(
            'completed',
            defaultValue: false,
          );

          if (!surveyCompleted) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Personalize your journey',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Complete the quick profile to get a custom calorie goal and better recommendations.\n'
                      'You can always do this later.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    FilledButton.icon(
                      icon: const Icon(Icons.assessment_outlined),
                      label: const Text('Take Profile Survey'),
                      onPressed: () => context.go('/survey'),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Manual mode active')),
                        );
                      },
                      child: const Text('Continue in Manual Mode'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Survey completed → show personalized dashboard
          final int age = box.get('age', defaultValue: 30);
          final String gender = box.get('gender', defaultValue: 'Other');
          final double heightCm = box.get('heightCm', defaultValue: 170.0);
          final double weightKg = box.get('weightKg', defaultValue: 70.0);
          final double? targetWeightKg = box.get('targetWeightKg');
          final String goal = box.get('goal', defaultValue: 'Maintain weight');
          final String activity = box.get(
            'activityLevel',
            defaultValue: 'Sedentary',
          );
          final String dietaryPref = box.get(
            'dietaryPreference',
            defaultValue: 'None / No preference',
          );
          final String? restrictions = box.get('restrictions');

          final double bmr = _calculateBMR(
            gender: gender,
            age: age,
            weightKg: weightKg,
            heightCm: heightCm,
          );

          final double dailyCalories = _applyActivityAndGoalMultiplier(
            bmr: bmr,
            activityLevel: activity,
            goal: goal,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi there!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your daily calorie target',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),

                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          '${dailyCalories.toStringAsFixed(0)} kcal/day',
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$goal • $activity',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (targetWeightKg != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Target: ${targetWeightKg.toStringAsFixed(1)} kg',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'Your Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProfileRow(label: 'Age', value: '$age years'),
                        _ProfileRow(
                          label: 'Current Weight',
                          value: '${weightKg.toStringAsFixed(1)} kg',
                        ),
                        _ProfileRow(
                          label: 'Height',
                          value: '${heightCm.toStringAsFixed(0)} cm',
                        ),
                        _ProfileRow(
                          label: 'Dietary Preference',
                          value: dietaryPref,
                        ),
                        if (restrictions != null && restrictions.isNotEmpty)
                          _ProfileRow(
                            label: 'Restrictions / Conditions',
                            value: restrictions,
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                FilledButton.icon(
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Profile'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () => context.go('/survey'),
                ),

                const SizedBox(height: 16),

                OutlinedButton.icon(
                  icon: const Icon(Icons.restaurant_menu),
                  label: const Text('Log Food'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () => context.go('/log-food'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _calculateBMR({
    required String gender,
    required int age,
    required double weightKg,
    required double heightCm,
  }) {
    double bmr = 10 * weightKg + 6.25 * heightCm - 5 * age;

    switch (gender.toLowerCase()) {
      case 'male':
        bmr += 5;
        break;
      case 'female':
        bmr -= 161;
        break;
      default:
        bmr -= 78; // rough average for 'other'
    }

    return bmr;
  }

  double _applyActivityAndGoalMultiplier({
    required double bmr,
    required String activityLevel,
    required String goal,
  }) {
    double multiplier = 1.2;

    switch (activityLevel) {
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
      // Maintain weight → no adjustment
    }

    return tdee.clamp(1200.0, 4000.0);
  }
}

class _ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
