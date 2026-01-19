import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart'; // ← FIXED: This import was missing!

import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/widgets/avatar_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _avatarPath;
  late Box _surveyBox;

  @override
  void initState() {
    super.initState();
    _surveyBox = Hive.box('surveyBox');
    _avatarPath = _surveyBox.get('avatar_path');
  }

  Future<void> _saveAvatar(String? path) async {
    await _surveyBox.put('avatar_path', path);
    if (!mounted) return;
    setState(() => _avatarPath = path);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.profileSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.yourProfile),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () =>
                context.go('/survey'), // ← now works with go_router
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: _surveyBox.listenable(),
        builder: (context, box, _) {
          final bool isCompleted = box.get('completed', defaultValue: false);
          final bool isManual = box.get('manual_mode', defaultValue: false);

          if (!isCompleted && !isManual) {
            // Show onboarding prompt if no survey done
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 24),
                    Text(
                      l10n.personalizeJourney,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.takeSurveyDesc, textAlign: TextAlign.center),
                    const SizedBox(height: 40),
                    FilledButton.icon(
                      icon: const Icon(Icons.assessment),
                      label: Text(l10n.takeSurvey),
                      onPressed: () => context.go('/survey'),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () async {
                        await box.put('manual_mode', true);
                        if (!mounted) return;
                        context.go('/log-food');
                      },
                      child: Text(l10n.continueManual),
                    ),
                  ],
                ),
              ),
            );
          }

          // Profile loaded
          final int age = box.get('age', defaultValue: 30);
          final String gender = box.get('gender', defaultValue: 'Other');
          final double height = box.get('heightCm', defaultValue: 170.0);
          final double weight = box.get('weightKg', defaultValue: 70.0);
          final double? targetWeight = box.get('targetWeightKg');
          final String goal = box.get('goal', defaultValue: 'Maintain weight');
          final String activity =
              box.get('activityLevel', defaultValue: 'Sedentary');
          final String dietary = box.get('dietaryPreference',
              defaultValue: 'None / No preference');
          final String? restrictions = box.get('restrictions');
          final String region = box.get('region', defaultValue: 'Other');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      AvatarPicker(
                        initialPath: _avatarPath,
                        onChanged: _saveAvatar,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.yourProfile,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Basic Info Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.basicInfo ?? 'Basic Info',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        _ProfileRow(label: l10n.age, value: '$age'),
                        _ProfileRow(label: l10n.gender, value: gender),
                        _ProfileRow(
                            label: l10n.heightCm,
                            value: '${height.toStringAsFixed(0)} cm'),
                        _ProfileRow(
                            label: l10n.currentWeightKg,
                            value: '${weight.toStringAsFixed(1)} kg'),
                        if (targetWeight != null)
                          _ProfileRow(
                              label: l10n.targetWeightKgOptional,
                              value: '${targetWeight.toStringAsFixed(1)} kg'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Goals Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.goalsAndLifestyle ?? 'Goals & Lifestyle',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        _ProfileRow(label: l10n.mainGoal, value: goal),
                        _ProfileRow(label: l10n.activityLevel, value: activity),
                        _ProfileRow(
                            label: l10n.dietaryPreference, value: dietary),
                        if (restrictions != null && restrictions.isNotEmpty)
                          _ProfileRow(
                              label: l10n.restrictionsLabel,
                              value: restrictions),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Location Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.location ?? 'Location',
                            style: Theme.of(context).textTheme.titleLarge),
                        _ProfileRow(label: l10n.regionCountry, value: region),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Manual Mode Notice
                if (isManual)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Manual Mode Active',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text(l10n.manualModeDesc),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            icon: const Icon(Icons.assessment),
                            label: Text(l10n.switchToPersonalized),
                            onPressed: () async {
                              await box.delete('manual_mode');
                              if (!mounted) return;
                              context.go('/survey');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 32),

                // Clear Profile Button
                FilledButton.icon(
                  icon: const Icon(Icons.delete_forever, color: Colors.white),
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  label: Text(l10n.startFresh,
                      style: const TextStyle(color: Colors.white)),
                  onPressed: _showClearDialog,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showClearDialog() async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearProfileTitle),
        content: Text(l10n.clearProfileDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              final box = Hive.box('surveyBox');
              await box.clear();
              await box.put('manual_mode', true);
              if (mounted) Navigator.pop(context, true);
            },
            child: Text(l10n.clear, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.profileCleared)),
      );
      setState(() {});
    }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
