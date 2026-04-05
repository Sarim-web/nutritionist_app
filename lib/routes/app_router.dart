import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/survey/presentation/survey_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/calorie_logging/presentation/food_logging_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/profile/presentation/profile_switcher_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/diet_builder/diet_builder.dart';
import '../core/widgets/scaffold_with_nav_bar.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 24),
          Text(
            'Page Not Found',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'No route found for "${state.uri}"',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => context.go('/onboarding'),
            child: const Text('Back to Start'),
          ),
        ],
      ),
    ),
  ),
  routes: [
    // Onboarding / Welcome (no bottom nav)
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Survey (standalone - no bottom nav)
    GoRoute(
      path: '/survey',
      builder: (context, state) => const SurveyScreen(),
    ),

    // Main app shell with bottom navigation
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithNavBar(child: child),
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

    // Other screens (standalone or modal)
    GoRoute(
      path: '/profile-switcher',
      builder: (context, state) => const ProfileSwitcherScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/diet-builder',
      builder: (context, state) => const DietBuilderScreen(),
    ),
  ],
);
