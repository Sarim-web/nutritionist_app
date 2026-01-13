import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutritionist_app/features/calorie_logging/presentation/food_logging_screen.dart';

// Import your actual screens — adjust paths if your folder structure is different
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/survey/presentation/survey_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';

final GoRouter router = GoRouter(
  // Start at onboarding for first-time users
  initialLocation: '/onboarding',

  // Optional: nice 404-style error page
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
            'Page not found',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text('No route for "${state.uri}"', textAlign: TextAlign.center),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.go('/onboarding'),
            child: const Text('Back to start'),
          ),
        ],
      ),
    ),
  ),

  routes: [
    // Onboarding (welcome + internet check)
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Survey screen
    GoRoute(path: '/survey', builder: (context, state) => const SurveyScreen()),

    // Home / Dashboard
    GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),

    GoRoute(
      path: '/log-food',
      builder: (context, state) => const FoodLoggingScreen(),
    ),
  ],
);
