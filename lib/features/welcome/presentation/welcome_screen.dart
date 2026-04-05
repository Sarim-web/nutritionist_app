import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = 'English';
  int _currentSlide = 0;
  late PageController _pageController;

  final List<String> _languages = [
    'English',
    'Urdu',
    'Punjabi',
    'Arabic',
    'Hindi',
    'Spanish',
    'French',
    'German',
    'Indonesian',
    'Turkish',
  ];

  final Map<String, String> _languageMap = {
    'English': 'en',
    'Urdu': 'ur',
    'Punjabi': 'pa',
    'Arabic': 'ar',
    'Hindi': 'hi',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Indonesian': 'id',
    'Turkish': 'tr',
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to VitaCalo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 300,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentSlide = index);
                  },
                  children: [
                    _buildSlide(
                      icon: Icons.assessment,
                      title: 'Complete Your Profile',
                      description:
                          'Tell us about your health goals and dietary preferences',
                    ),
                    _buildSlide(
                      icon: Icons.restaurant,
                      title: 'Log Your Meals',
                      description:
                          'Track calories, nutrition, and meal timing with ease',
                    ),
                    _buildSlide(
                      icon: Icons.trending_up,
                      title: 'Track Your Progress',
                      description:
                          'View detailed charts and history of your nutrition journey',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentSlide == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentSlide == index
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Select your preferred language:'),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedLanguage,
                items: _languages
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedLanguage = v!),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveAndContinue,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _saveAndContinue() async {
    final settingsBox = Hive.box('settings'); // Correct box!

    final String name = _selectedLanguage;
    String code = _languageMap[name] ?? 'en';

    await settingsBox.put('language_code', code);
    await settingsBox.put('language_name', name); // optional

    if (context.mounted) {
      context.go('/onboarding'); // or '/' if no onboarding needed
    }
  }
}
