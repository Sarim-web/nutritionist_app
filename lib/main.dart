import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

import 'l10n/app_localizations.dart';

// Correct relative imports based on your folder structure
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/survey/presentation/survey_screen.dart';
import 'features/calorie_logging/presentation/food_logging_screen.dart';
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

        // Clean up any old full-name saves (backward compatibility)
        if (languageCode == 'English') languageCode = 'en';
        if (languageCode == 'Urdu') languageCode = 'ur';

        final Locale locale = Locale(languageCode);

        print('Loaded language code from Hive: $languageCode');
        print('Applied locale: $locale');

        return MaterialApp.router(
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            // Enforce the user's saved choice over device locale
            print('Locale resolution: using saved $languageCode');
            return supportedLocales.firstWhere(
              (l) => l.languageCode == languageCode,
              orElse: () => const Locale('en'),
            );
          },
          builder: (context, child) {
            final effectiveLocale = Localizations.localeOf(context);
            final isRtl = effectiveLocale.languageCode == 'ur' ||
                effectiveLocale.languageCode == 'ar' ||
                effectiveLocale.languageCode == 'pa';

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

  String? _getFontFamily(String languageCode) {
    switch (languageCode) {
      case 'ur':
        return 'NotoNastaliqUrdu';
      case 'ar':
        return 'NotoSansArabic'; // Add this font in pubspec.yaml if needed
      case 'pa':
      case 'hi':
        return 'NotoSansDevanagari'; // Optional – add font if you want better Hindi/Punjabi
      default:
        return null; // Use system default for others
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
          GoRoute(
            path: '/welcome',
            builder: (context, state) => const WelcomeScreen(),
          ),
          GoRoute(
            path: '/',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/survey',
            builder: (context, state) => const SurveyScreen(),
          ),
          GoRoute(
            path: '/log-food',
            builder: (context, state) => const FoodLoggingScreen(),
          ),
        ],
      );
}
