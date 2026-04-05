import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../l10n/app_localizations.dart';
import '../../../core/models/profile.dart';
import '../../../core/widgets/avatar_picker.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, settingsBox, _) {
        final currentId =
            settingsBox.get('current_profile_id', defaultValue: 'main');

        return ValueListenableBuilder<Box>(
          valueListenable: Hive.box('profiles').listenable(),
          builder: (context, profilesBox, _) {
            final currentProfile = profilesBox.get(currentId) as Map?;
            final currentProfileName =
                currentProfile?['name'] as String? ?? 'Main Profile';
            final avatarPath = currentProfile?['avatarPath'] as String?;

            return Scaffold(
              appBar: AppBar(
                title: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    '✨ VitaCalo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                centerTitle: true,
                // No back button here anymore — removed because it was non-functional
                // Inner screens keep their own working back buttons
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'switch') {
                          if (context.mounted) context.go('/profile-switcher');
                        } else if (value == 'new') {
                          await _createNewProfile(context);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          enabled: false,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: avatarPath != null
                                    ? (avatarPath.startsWith('assets/')
                                        ? AssetImage(avatarPath)
                                        : FileImage(File(avatarPath)))
                                    : null,
                                child: avatarPath == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                currentProfileName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                            value: 'switch', child: Text('Switch Profile')),
                        const PopupMenuItem(
                            value: 'new', child: Text('Create New Profile')),
                      ],
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: avatarPath != null
                                ? (avatarPath.startsWith('assets/')
                                    ? AssetImage(avatarPath)
                                    : FileImage(File(avatarPath)))
                                : null,
                            child: avatarPath == null
                                ? const Icon(Icons.person, size: 20)
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Text(currentProfileName),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: const Text(
                        'VitaCalo Menu',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {
                        context.go('/');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_circle),
                      title: const Text('Log Food'),
                      onTap: () {
                        context.go('/log-food');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text('History'),
                      onTap: () {
                        context.go('/history');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {
                        context.go('/profile');
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        context.go('/settings');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        showAboutDialog(context: context);
                      },
                    ),
                  ],
                ),
              ),
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _getSelectedIndex(location),
                onTap: (index) => _onTap(index, context),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Colors.grey[600],
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline), label: 'Log'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history_toggle_off), label: 'History'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline), label: 'Profile'),
                ],
              ),
            );
          },
        );
      },
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/log-food')) return 1;
    if (location.startsWith('/history')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/log-food');
        break;
      case 2:
        context.go('/history');
        break;
      case 3:
        context.go('/profile');
        break;
    }
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

    if (name == null || name.isEmpty || !context.mounted) return;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final profile = Profile(id: id, name: name, avatarPath: avatarPath);

    await Hive.box('profiles').put(id, profile.toMap());
    if (!context.mounted) return;

    await Hive.openBox('survey_$id');
    if (!context.mounted) return;

    await Hive.openBox('foodLogs_$id');
    if (!context.mounted) return;

    await Hive.box('settings').put('current_profile_id', id);
    if (!context.mounted) return;

    context.go('/');
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.createdProfile} $name')),
    );
  }
}
