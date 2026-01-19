import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

import 'l10n/app_localizations.dart';

import 'core/widgets/scaffold_with_nav_bar.dart'; // ← new import

import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/survey/presentation/survey_screen.dart';
import 'features/calorie_logging/presentation/food_logging_screen.dart';
import 'features/history/presentation/history_screen.dart'; // ← new
import 'features/profile/presentation/profile_screen.dart'; // ← new
import 'features/welcome/presentation/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('surveyBox');
  await Hive.openBox('foodLogs');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('surveyBox').listenable(),
      builder: (context, box, _) {
        String languageCode = box.get('language_code', defaultValue: 'en');

        // Backward compatibility for old saves
        if (languageCode == 'English') languageCode = 'en';
        if (languageCode == 'Urdu') languageCode = 'ur';

        final Locale locale = Locale(languageCode);

        print('Loaded language: $languageCode → $locale');

        return MaterialApp.router(
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (deviceLocale, supported) {
            return supported.firstWhere(
              (l) => l.languageCode == languageCode,
              orElse: () => const Locale('en'),
            );
          },
          builder: (context, child) {
            final loc = Localizations.localeOf(context);
            final isRtl = loc.languageCode == 'ur' ||
                loc.languageCode == 'ar' ||
                loc.languageCode == 'pa';

            return Directionality(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          title: 'Nutritionist',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: _getFontFamily(languageCode),
                ),
          ),
        );
      },
    );
  }

  String? _getFontFamily(String code) {
    switch (code) {
      case 'ur':
      case 'pa':
        return 'NotoNastaliqUrdu';
      case 'ar':
        return 'NotoSansArabic';
      case 'hi':
      case 'pa': // fallback if separate font added later
        return 'NotoSansDevanagari';
      default:
        return null;
    }
  }

  GoRouter get _router => GoRouter(
        initialLocation: '/',
        redirect: (context, state) {
          final box = Hive.box('surveyBox');
          final String? langCode = box.get('language_code');
          if (langCode == null && state.uri.toString() != '/welcome') {
            return '/welcome';
          }
          return null;
        },
        routes: [
          // Welcome & Survey are outside shell (no bottom nav)
          GoRoute(
            path: '/welcome',
            builder: (context, state) => const WelcomeScreen(),
          ),
          GoRoute(
            path: '/survey',
            builder: (context, state) => const SurveyScreen(),
          ),

          // Shell with bottom nav for main app
          ShellRoute(
            builder: (context, state, child) =>
                ScaffoldWithNavBar(child: child),
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DashboardScreen(),
              ),
              GoRoute(
                path: '/log-food',
                builder: (context, state) => const FoodLoggingScreen(),
              ),
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryScreen(),
              ),
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      );
}
