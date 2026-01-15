import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ValueListenableBuilder<Box>(
            valueListenable: Hive.box('surveyBox').listenable(),
            builder: (context, box, _) {
              final bool surveyCompleted =
                  box.get('completed', defaultValue: false);
              final bool manualMode =
                  box.get('manual_mode', defaultValue: false);

              if (surveyCompleted) {
                // Personalized dashboard
                final int age = box.get('age', defaultValue: 30);
                final String gender = box.get('gender', defaultValue: 'Other');
                final double heightCm =
                    box.get('heightCm', defaultValue: 170.0);
                final double weightKg = box.get('weightKg', defaultValue: 70.0);
                final double? targetWeightKg = box.get('targetWeightKg');
                final String goal =
                    box.get('goal', defaultValue: 'Maintain weight');
                final String activity =
                    box.get('activityLevel', defaultValue: 'Sedentary');
                final String dietaryPref = box.get('dietaryPreference',
                    defaultValue: 'None / No preference');
                final String? restrictions = box.get('restrictions');

                final double bmr = _calculateBMR(
                  gender: gender,
                  age: age,
                  weightKg: weightKg,
                  heightCm: heightCm,
                );

                final double dailyTarget = _applyActivityAndGoalMultiplier(
                  bmr: bmr,
                  activityLevel: activity,
                  goal: goal,
                );

                final double loggedToday = _getTodayLoggedCalories();

                final double progress =
                    (loggedToday / dailyTarget).clamp(0.0, 1.5);
                final Color progressColor = progress < 0.8
                    ? Colors.green
                    : progress < 1.0
                        ? Colors.orange
                        : Colors.red;

                final String progressMessage = progress < 0.8
                    ? 'Good pace — keep going!'
                    : progress < 1.0
                        ? 'Almost there — stay mindful'
                        : 'Over target — consider lighter choices';

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Daily Progress',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 24),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              strokeWidth: 12,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.3),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(progressColor),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${loggedToday.toStringAsFixed(0)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: progressColor,
                                    ),
                              ),
                              Text(
                                'of ${dailyTarget.toStringAsFixed(0)} kcal',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        progressMessage,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: progressColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ProfileRow(
                                  label: 'Target',
                                  value:
                                      '${dailyTarget.toStringAsFixed(0)} kcal/day'),
                              _ProfileRow(label: 'Goal', value: goal),
                              _ProfileRow(label: 'Activity', value: activity),
                              if (targetWeightKg != null)
                                _ProfileRow(
                                    label: 'Target Weight',
                                    value:
                                        '${targetWeightKg.toStringAsFixed(1)} kg'),
                              _ProfileRow(
                                  label: 'Dietary Preference',
                                  value: dietaryPref),
                              if (restrictions != null &&
                                  restrictions.isNotEmpty)
                                _ProfileRow(
                                    label: 'Restrictions', value: restrictions),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilledButton.icon(
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Edit Profile'),
                            onPressed: () => context.go('/survey'),
                          ),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Log Food'),
                            onPressed: () => context.go('/log-food'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        label: const Text('Start Fresh (Clear Profile)',
                            style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red)),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Clear Profile?'),
                              content: const Text(
                                'This will remove all saved profile info and calorie logs. You can take the survey again for a fresh start.',
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel')),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Clear',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await box.clear();
                            await Hive.box('foodLogs').clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Profile and logs cleared')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else if (manualMode) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.handyman,
                            size: 80, color: Colors.blue),
                        const SizedBox(height: 24),
                        Text(
                          'Manual Mode Active',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'You are tracking calories without a personalized goal.\nLog foods freely — you can take the survey anytime for custom targets.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        FilledButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Log Food'),
                          onPressed: () => context.go('/log-food'),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () async {
                            await box.delete('manual_mode');
                            if (context.mounted) context.go('/survey');
                          },
                          child: const Text(
                              'Switch to Personalized Mode (Take Survey)'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
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
                          'Complete the quick profile to get a custom calorie goal and better recommendations.',
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
                          onPressed: () async {
                            await box.put('manual_mode', true);
                            if (context.mounted) context.go('/log-food');
                          },
                          child: const Text('Continue in Manual Mode'),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  double _getTodayLoggedCalories() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final box = Hive.box('foodLogs');
    double total = 0.0;

    for (var entry in box.values) {
      if (entry is Map && entry['date'] == today) {
        final cal = (entry['calories'] as num? ?? 0.0) *
            (entry['quantity'] as num? ?? 1.0);
        total += cal;
      }
    }
    return total;
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
        bmr -= 78;
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
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
