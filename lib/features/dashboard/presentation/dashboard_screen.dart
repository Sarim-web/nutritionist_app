import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/providers/profile_provider.dart';
import '../../../../../core/widgets/animated_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboard),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              // FIXED: Listen to settings box for profile ID changes
              return ValueListenableBuilder<Box>(
                valueListenable: Hive.box('settings')
                    .listenable(keys: ['current_profile_id']),
                builder: (context, settingsBox, _) {
                  // Re-read current profile ID fresh
                  final currentId = settingsBox.get('current_profile_id',
                      defaultValue: 'main');

                  // Ensure provider is in sync (should be handled in main.dart, but double-check)
                  if (profileProvider.currentProfileId != currentId) {
                    profileProvider.switchProfile(currentId);
                  }

                  final surveyBox = profileProvider.surveyBox;
                  final foodLogsBox = profileProvider.foodLogsBox;
                  final valueListenable = surveyBox.listenable();

                  return ValueListenableBuilder<Box>(
                    valueListenable: valueListenable,
                    builder: (context, box, _) {
                      final bool surveyCompleted =
                          box.get('completed', defaultValue: false);
                      final bool manualMode =
                          box.get('manual_mode', defaultValue: false);

                      final bool hasSurveyData =
                          box.isNotEmpty && surveyCompleted == true;
                      if (!hasSurveyData) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.takeSurveyDesc)),
                          );
                          context.go('/survey');
                        });

                        return Center(child: const CircularProgressIndicator());
                      }

                      if (surveyCompleted) {
                        final int age = box.get('age', defaultValue: 30);
                        final String gender =
                            box.get('gender', defaultValue: 'Other');
                        final double heightCm =
                            box.get('heightCm', defaultValue: 170.0);
                        final double weightKg =
                            box.get('weightKg', defaultValue: 70.0);
                        final double? targetWeightKg =
                            box.get('targetWeightKg');
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

                        final double dailyTarget =
                            _applyActivityAndGoalMultiplier(
                          bmr: bmr,
                          activityLevel: activity,
                          goal: goal,
                        );

                        final double loggedToday =
                            _getTodayLoggedCalories(foodLogsBox);

                        final double progress =
                            (loggedToday / dailyTarget).clamp(0.0, 1.5);
                        final Color progressColor = progress < 0.8
                            ? Colors.green
                            : progress < 1.0
                                ? Colors.orange
                                : Colors.red;

                        final String progressMessage = progress < 0.8
                            ? l10n.goodPace
                            : progress < 1.0
                                ? l10n.almostThere
                                : l10n.overTarget;

                        // Show periodic backup reminder (once every 3 days)
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final settingsBox = Hive.box('settings');
                          final lastBackupReminder = settingsBox
                              .get('last_backup_reminder', defaultValue: 0);
                          final now = DateTime.now().millisecondsSinceEpoch;
                          const reminderIntervalMs =
                              3 * 24 * 60 * 60 * 1000; // 3 days

                          if (now - lastBackupReminder > reminderIntervalMs) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Tip: Export your data regularly to backup your nutrition logs',
                                ),
                                action: SnackBarAction(
                                  label: 'Learn More',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Data export feature coming soon!',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                duration: const Duration(seconds: 5),
                              ),
                            );
                            settingsBox.put('last_backup_reminder', now);
                          }
                        });

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                l10n.dailyProgress,
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
                                          .withValues(alpha: 0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          progressColor),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        loggedToday.toStringAsFixed(0),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: progressColor,
                                            ),
                                      ),
                                      Text(
                                        l10n.ofTarget(
                                            dailyTarget.toStringAsFixed(0)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _ProfileRow(
                                          label: l10n.target,
                                          value:
                                              '${dailyTarget.toStringAsFixed(0)} ${l10n.kcalDay}'),
                                      _ProfileRow(
                                          label: l10n.goal, value: goal),
                                      _ProfileRow(
                                          label: l10n.activity,
                                          value: activity),
                                      if (targetWeightKg != null)
                                        _ProfileRow(
                                            label: l10n.targetWeight,
                                            value:
                                                '${targetWeightKg.toStringAsFixed(1)} kg'),
                                      _ProfileRow(
                                          label: l10n.dietaryPreference,
                                          value: dietaryPref),
                                      if (restrictions != null &&
                                          restrictions.isNotEmpty)
                                        _ProfileRow(
                                            label: l10n.restrictions,
                                            value: restrictions),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AnimatedFilledButton(
                                    icon: const Icon(Icons.edit_outlined),
                                    label: Text(l10n.editProfile),
                                    onPressed: () => context.go('/survey'),
                                  ),
                                  AnimatedElevatedButton(
                                    onPressed: () => context.go('/log-food'),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.add),
                                        const SizedBox(width: 8),
                                        Text(l10n.logFoodButton),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton.icon(
                                    icon: const Icon(
                                        Icons.restaurant_menu_outlined),
                                    label: const Text('Diet Builder'),
                                    onPressed: () =>
                                        context.go('/diet-builder'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              OutlinedButton.icon(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                label: Text(l10n.startFresh,
                                    style: const TextStyle(color: Colors.red)),
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.red)),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(l10n.clearProfileTitle),
                                      content: Text(l10n.clearProfileDesc),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text(l10n.cancel),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text(
                                            l10n.clear,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm == true && context.mounted) {
                                    await box.clear();
                                    await foodLogsBox.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(l10n.profileCleared)),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 24),

                              // Backup Reminder Card
                              Card(
                                color: Colors.blue[50],
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.backup,
                                              color: Colors.blue[700]),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'Export Your Data',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Regularly export your nutrition data to keep it safe and backed up.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: double.infinity,
                                        child: OutlinedButton.icon(
                                          icon: const Icon(Icons.download),
                                          label: const Text('Export Data'),
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Data export feature coming soon!'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                  l10n.manualModeActive,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  l10n.manualModeDesc,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 40),
                                AnimatedFilledButton(
                                  icon: const Icon(Icons.add),
                                  label: Text(l10n.logFoodButton),
                                  onPressed: () => context.go('/log-food'),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: () async {
                                    await box.delete('manual_mode');
                                    if (context.mounted) context.go('/survey');
                                  },
                                  child: Text(l10n.switchToPersonalized),
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
                                  l10n.personalizeJourney,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  l10n.takeSurveyDesc,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 40),
                                AnimatedFilledButton(
                                  icon: const Icon(Icons.assessment_outlined),
                                  label: Text(l10n.takeSurvey),
                                  onPressed: () => context.go('/survey'),
                                ),
                                const SizedBox(height: 16),
                                OutlinedButton(
                                  onPressed: () async {
                                    await box.put('manual_mode', true);
                                    if (context.mounted) {
                                      context.go('/log-food');
                                    }
                                  },
                                  child: Text(l10n.continueManual),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  double _getTodayLoggedCalories(Box foodLogsBox) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    double total = 0.0;

    for (var entry in foodLogsBox.values) {
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
