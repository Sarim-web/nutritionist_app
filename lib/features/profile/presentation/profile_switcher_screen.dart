import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/models/profile.dart';
import '../../../../core/widgets/avatar_picker.dart';

class ProfileSwitcherScreen extends StatelessWidget {
  const ProfileSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.switchProfile),
        leading: BackButton(
          onPressed: () {
            if (context.mounted) {
              context.go('/profile');
            }
          },
        ),
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box('profiles').listenable(),
        builder: (context, profilesBox, _) {
          final profiles = profilesBox.values
              .map((e) => Profile.fromMap(e.cast<String, dynamic>()))
              .toList();

          if (profiles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.noProfilesYet),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _createNewProfile(context),
                    child: Text(l10n.createNewProfile),
                  ),
                ],
              ),
            );
          }

          final currentId = Hive.box('settings')
              .get('current_profile_id', defaultValue: 'main');

          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              final isCurrent = profile.id == currentId;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: profile.avatarPath != null
                      ? (profile.avatarPath!.startsWith('assets/')
                          ? AssetImage(profile.avatarPath!)
                          : FileImage(File(profile.avatarPath!)))
                      : null,
                  child: profile.avatarPath == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                title: Text(profile.name),
                trailing: isCurrent
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProfile(context, profile),
                      ),
                onTap: () async {
                  if (isCurrent) {
                    if (context.mounted) Navigator.pop(context);
                    return;
                  }

                  await Hive.box('settings')
                      .put('current_profile_id', profile.id);

                  await Hive.openBox('survey_${profile.id}');
                  await Hive.openBox('foodLogs_${profile.id}');

                  if (!context.mounted) return;

                  Navigator.pop(context);

                  // FIXED: Delay navigation to let rebuild settle (prevents black screen race)
                  await Future.delayed(const Duration(milliseconds: 300));

                  if (!context.mounted) return;

                  context.go('/');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewProfile(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _createNewProfile(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    String? avatarPath;

    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.profileName),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: l10n.profileNameHint),
              ),
              const SizedBox(height: 16),
              AvatarPicker(
                onChanged: (path) => avatarPath = path,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              final trimmed = nameController.text.trim();
              if (trimmed.isNotEmpty) {
                Navigator.pop(dialogContext, trimmed);
              }
            },
            child: Text(l10n.create),
          ),
        ],
      ),
    );

    if (name == null || name.isEmpty) return;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final profile = Profile(id: id, name: name, avatarPath: avatarPath);

    await Hive.box('profiles').put(id, profile.toMap());
    await Hive.box('settings').put('current_profile_id', id);

    await Hive.openBox('survey_$id');
    await Hive.openBox('foodLogs_$id');

    if (!context.mounted) return;

    // FIXED: Delay navigation to let rebuild settle (prevents black screen race)
    await Future.delayed(const Duration(milliseconds: 300));

    context.go('/');

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.createdProfile} $name')),
    );
  }

  Future<void> _deleteProfile(BuildContext context, Profile profile) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${l10n.deleteProfile} ${profile.name}?'),
        content: Text(l10n.deleteProfileDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await Hive.box('profiles').delete(profile.id);
    await Hive.box('survey_${profile.id}').deleteFromDisk();
    await Hive.box('foodLogs_${profile.id}').deleteFromDisk();

    final currentId = Hive.box('settings').get('current_profile_id');
    if (currentId == profile.id) {
      await Hive.box('settings').put('current_profile_id', 'main');
      if (context.mounted) context.go('/');
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.profileDeleted} ${profile.name}')),
    );
  }
}
