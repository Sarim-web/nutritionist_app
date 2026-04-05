import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nutritrack/features/welcome/presentation/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/profile_provider.dart';

import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Open global boxes
  await Hive.openBox('profiles');
  await Hive.openBox('settings');

  // Get current profile ID
  final settings = Hive.box('settings');
  final currentProfileId =
      settings.get('current_profile_id', defaultValue: 'main');

  // Open profile-specific boxes
  await Hive.openBox('survey_$currentProfileId');
  await Hive.openBox('foodLogs_$currentProfileId');

  // Legacy boxes
  await Hive.openBox('surveyBox');
  await Hive.openBox('foodLogs');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: Consumer2<ThemeProvider, ProfileProvider>(
        builder: (context, themeProvider, profileProvider, child) {
          return ValueListenableBuilder<Box>(
            valueListenable: Hive.box('settings').listenable(),
            builder: (context, settingsBox, _) {
              final languageCode =
                  settingsBox.get('language_code') as String? ?? 'en';
              final locale = Locale(languageCode);

              // If no language set at all → force welcome
              if (languageCode == 'en' &&
                  settingsBox.get('language_code') == null) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: const WelcomeScreen(),
                  locale: const Locale('en'),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                );
              }

              // FIXED: Listen to current_profile_id changes and force provider refresh
              final currentId =
                  settingsBox.get('current_profile_id', defaultValue: 'main');
              if (profileProvider.currentProfileId != currentId) {
                profileProvider
                    .switchProfile(currentId); // Triggers notifyListeners()
              }

              // Normal app with dynamic locale from settings
              return MaterialApp.router(
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                builder: (context, child) {
                  final loc = Localizations.localeOf(context);
                  final isRtl = loc.languageCode == 'ur' ||
                      loc.languageCode == 'ar' ||
                      loc.languageCode == 'pa';

                  return Directionality(
                    textDirection:
                        isRtl ? TextDirection.rtl : TextDirection.ltr,
                    child: child!,
                  );
                },
                debugShowCheckedModeBanner: false,
                routerConfig: router,
                title: 'VitaCalo',
                theme: themeProvider.currentTheme,
              );
            },
          );
        },
      ),
    );
  }
}
