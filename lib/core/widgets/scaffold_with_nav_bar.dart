import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('surveyBox').listenable(),
      builder: (context, box, _) {
        // Stub: later we'll have real multi-profile list
        final String currentProfileName =
            box.get('profile_name', defaultValue: 'Main Profile');
        final String? avatarPath = box.get('avatar_path');

        return Scaffold(
          appBar: AppBar(
            title: Text(_getAppBarTitle(location)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'switch') {
                      _showProfileSwitcher(context);
                    } else if (value == 'new') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('New profile coming soon')),
                      );
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
                          Text(currentProfileName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
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
                    'Nutritionist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Settings page coming soon')),
                    );
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

  String _getAppBarTitle(String location) {
    if (location.startsWith('/log-food')) return 'Log Food';
    if (location.startsWith('/history')) return 'History';
    if (location.startsWith('/profile')) return 'Profile';
    return 'Nutritionist';
  }

  void _showProfileSwitcher(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Switch Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('Main Profile'),
                subtitle: const Text('Current'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Already on Main Profile')),
                  );
                },
              ),
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person_add)),
                title: const Text('Family Member 1'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Switching to Family Member 1 (stub)')),
                  );
                },
              ),
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person_add)),
                title: const Text('Create New Profile'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('New profile creation coming soon')),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
