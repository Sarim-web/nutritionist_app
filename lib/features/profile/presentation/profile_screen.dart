import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/widgets/avatar_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Box _surveyBox;

  @override
  void initState() {
    super.initState();
    final settingsBox = Hive.box('settings');
    final currentId =
        settingsBox.get('current_profile_id', defaultValue: 'main');
    _surveyBox = Hive.box('survey_$currentId');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.yourProfile),
        leading: BackButton(
          onPressed: () {
            if (context.mounted) {
              context.go('/');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/survey'),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: _surveyBox.listenable(),
        builder: (context, box, _) {
          final bool isCompleted = box.get('completed', defaultValue: false);
          final bool isManual = box.get('manual_mode', defaultValue: false);

          // Get avatar path every time the box changes
          final String? avatarPath = box.get('avatar_path');

          if (!isCompleted && !isManual) {
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
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      onPressed: () => context.go('/survey'),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.skip_next),
                      label: Text(l10n.continueManual),
                      onPressed: () async {
                        await box.put('manual_mode', true);
                        if (mounted) context.go('/log-food');
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          final int age = box.get('age', defaultValue: 0);
          final String gender = box.get('gender', defaultValue: '');
          final double heightCm = box.get('heightCm', defaultValue: 0.0);
          final double weightKg = box.get('weightKg', defaultValue: 0.0);
          final double? targetWeightKg = box.get('targetWeightKg');
          final String goal = box.get('goal', defaultValue: '');
          final String activityLevel =
              box.get('activityLevel', defaultValue: '');
          final String dietaryPref =
              box.get('dietaryPreference', defaultValue: '');
          final String? restrictions = box.get('restrictions');
          final String region = box.get('region', defaultValue: '');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar Section - now updates live when box changes
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: avatarPath != null
                          ? (avatarPath.startsWith('assets/')
                              ? AssetImage(avatarPath)
                              : FileImage(File(avatarPath)))
                          : null,
                      child: avatarPath == null
                          ? Icon(Icons.person,
                              size: 80, color: Colors.grey[400])
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: FloatingActionButton.small(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => AvatarPicker(
                              initialPath: avatarPath,
                              onChanged: (path) async {
                                await box.put('avatar_path', path);
                              },
                            ),
                          );
                        },
                        child: const Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.yourProfile,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Basic Info Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Basic Information',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        _ProfileRow(label: l10n.age, value: '$age years'),
                        _ProfileRow(label: l10n.gender, value: gender),
                        _ProfileRow(
                            label: l10n.height,
                            value: '${heightCm.toStringAsFixed(1)} cm'),
                        _ProfileRow(
                            label: l10n.currentWeight,
                            value: '${weightKg.toStringAsFixed(1)} kg'),
                        if (targetWeightKg != null)
                          _ProfileRow(
                              label: l10n.targetWeight,
                              value: '${targetWeightKg.toStringAsFixed(1)} kg'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Goals & Lifestyle Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Goals & Lifestyle',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        _ProfileRow(label: l10n.goal, value: goal),
                        _ProfileRow(
                            label: l10n.activityLevel, value: activityLevel),
                        _ProfileRow(
                            label: l10n.dietaryPreference, value: dietaryPref),
                        if (restrictions != null && restrictions.isNotEmpty)
                          _ProfileRow(
                              label: l10n.restrictions, value: restrictions),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Location Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        _ProfileRow(label: l10n.regionCountry, value: region),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Manual Mode Notice
                if (isManual)
                  Card(
                    color: Colors.amber[50],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.amber[800]),
                              const SizedBox(width: 12),
                              Text('Manual Mode Active',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(l10n.manualModeDesc,
                              textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            icon: const Icon(Icons.assessment),
                            label: Text(l10n.switchToPersonalized),
                            onPressed: () async {
                              await box.delete('manual_mode');
                              if (mounted) context.go('/survey');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                // Clear Profile Button
                FilledButton.icon(
                  icon: const Icon(Icons.delete_forever),
                  label: Text(l10n.startFresh),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
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
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.clearProfileTitle),
        content: Text(l10n.clearProfileDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await _surveyBox.clear();
              await _surveyBox.put('manual_mode', true);
              if (mounted) Navigator.pop(dialogContext, true);
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
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
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
