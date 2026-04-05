import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _restartWithNotice(
      BuildContext context, String newLangName) async {
    // Show explanation dialog FIRST
    final shouldClose = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Restart Required'),
          content: Text(
            'Switch to $newLangName?\n\n'
            'The app will now close.\n'
            'Please reopen it to see the change.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Close App'),
            ),
          ],
        );
      },
    );

    if (shouldClose != true) return;

    // Fade-out animation
    await _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 400)); // Let fade finish

    // Close app
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final settingsBox = Hive.box('settings');

    final currentLang = settingsBox.get('language_code', defaultValue: 'en');
    final currentWeightUnit =
        settingsBox.get('weight_unit', defaultValue: 'kg');
    final currentHeightUnit =
        settingsBox.get('height_unit', defaultValue: 'cm');

    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0).animate(_fadeAnimation),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.settings),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              if (context.mounted) context.go('/');
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Dark Mode
              SwitchListTile(
                title: Text(l10n.darkMode),
                subtitle: Text(themeProvider.isDarkMode ? l10n.on : l10n.off),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                  settingsBox.put('dark_mode', value);
                },
                secondary: const Icon(Icons.dark_mode),
              ),

              const Divider(),

              /// Language
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.language),
                subtitle: Text(_getLanguageName(currentLang)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      String selected = currentLang;

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Text(l10n.selectLanguage),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  _LangTile('English', 'en'),
                                  _LangTile('Urdu', 'ur'),
                                  _LangTile('Punjabi', 'pa'),
                                  _LangTile('Arabic', 'ar'),
                                  _LangTile('Hindi', 'hi'),
                                  _LangTile('Spanish', 'es'),
                                  _LangTile('French', 'fr'),
                                  _LangTile('German', 'de'),
                                  _LangTile('Indonesian', 'id'),
                                  _LangTile('Turkish', 'tr'),
                                ].map((tile) {
                                  return RadioListTile<String>(
                                    title: Text(tile.name),
                                    value: tile.code,
                                    groupValue: selected,
                                    onChanged: (v) =>
                                        setState(() => selected = v!),
                                  );
                                }).toList(),
                              ),
                            ),
                            actions: [
                              /// Cancel
                              TextButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                child: Text(l10n.cancel),
                              ),

                              /// Save & Restart
                              TextButton(
                                onPressed: selected == currentLang
                                    ? null
                                    : () async {
                                        await settingsBox.put(
                                            'language_code', selected);
                                        Navigator.pop(dialogContext);
                                        await _restartWithNotice(
                                          context,
                                          _getLanguageName(selected),
                                        );
                                      },
                                child: const Text('Save & Restart'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),

              const Divider(),

              /// Weight Unit
              _unitDialog(
                context,
                l10n,
                icon: Icons.scale,
                title: l10n.weightUnit,
                current: currentWeightUnit,
                options: const {
                  'kg': 'Kilograms (kg)',
                  'lb': 'Pounds (lb)',
                },
                onSave: (v) => settingsBox.put('weight_unit', v),
              ),

              const Divider(),

              /// Height Unit
              _unitDialog(
                context,
                l10n,
                icon: Icons.height,
                title: l10n.heightUnit,
                current: currentHeightUnit,
                options: const {
                  'cm': 'Centimeters (cm)',
                  'in': 'Inches (in)',
                },
                onSave: (v) => settingsBox.put('height_unit', v),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _unitDialog(
    BuildContext context,
    AppLocalizations l10n, {
    required IconData icon,
    required String title,
    required String current,
    required Map<String, String> options,
    required Function(String) onSave,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(options[current]!),
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            String selected = current;
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options.entries.map((e) {
                      return RadioListTile<String>(
                        title: Text(e.value),
                        value: e.key,
                        groupValue: selected,
                        onChanged: (v) => setState(() => selected = v!),
                      );
                    }).toList(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(l10n.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        onSave(selected);
                        Navigator.pop(dialogContext);
                      },
                      child: Text(l10n.save),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ur':
        return 'Urdu';
      case 'pa':
        return 'Punjabi';
      case 'ar':
        return 'Arabic';
      case 'hi':
        return 'Hindi';
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'id':
        return 'Indonesian';
      case 'tr':
        return 'Turkish';
      default:
        return 'Unknown';
    }
  }
}

/// Helper
class _LangTile {
  final String name;
  final String code;
  const _LangTile(this.name, this.code);
}
