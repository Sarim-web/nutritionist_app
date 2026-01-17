import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = 'English';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Nutritionist',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

  void _saveAndContinue() async {
    final box = Hive.box('surveyBox');
    final String name = _selectedLanguage;
    String code = _languageMap[name] ?? 'en'; // Default to en if not supported
    await box.put('language_name', name);
    await box.put('language_code', code);
    if (context.mounted) {
      context.go('/');
    }
  }
}
