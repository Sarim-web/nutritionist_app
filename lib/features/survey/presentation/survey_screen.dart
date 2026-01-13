import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController(); // cm
  final _weightController = TextEditingController(); // kg
  final _targetWeightController = TextEditingController(); // kg
  final _restrictionsController = TextEditingController(); // free text

  String? _gender;
  String? _goal;
  String? _activityLevel;
  double _confidence = 0.5;
  String _selectedLanguage = 'English';
  String? _dietaryPreference;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _goals = [
    'Lose weight',
    'Maintain weight',
    'Gain muscle',
    'Improve health',
  ];
  final List<String> _activityLevels = [
    'Sedentary (little or no exercise)',
    'Lightly active (light exercise/sports 1-3 days/week)',
    'Moderately active (moderate exercise/sports 3-5 days/week)',
    'Very active (hard exercise/sports 6-7 days/week)',
    'Super active (very hard exercise & physical job)',
  ];
  final List<String> _dietaryPreferences = [
    'None / No preference',
    'Vegetarian',
    'Vegan',
    'Halal',
    'Kosher',
    'Keto / Low-carb',
    'Paleo',
    'Gluten-free',
    'Other (specify in restrictions)',
  ];
  final List<String> _languages = [
    'English',
    'Urdu',
    'Arabic',
    'Hindi',
    'Punjabi',
    'Spanish',
    'French',
    'German',
    'Indonesian',
    'Turkish',
  ];

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    _restrictionsController.dispose();
    super.dispose();
  }

  Future<void> _saveSurvey() async {
    if (_formKey.currentState!.validate()) {
      final box = await Hive.openBox('surveyBox');

      await box.putAll({
        'age': int.tryParse(_ageController.text) ?? 30,
        'gender': _gender ?? 'Other',
        'heightCm': double.tryParse(_heightController.text) ?? 170.0,
        'weightKg': double.tryParse(_weightController.text) ?? 70.0,
        'targetWeightKg': double.tryParse(_targetWeightController.text) ?? null,
        'goal': _goal ?? 'Maintain weight',
        'activityLevel': _activityLevel ?? 'Sedentary',
        'confidence': _confidence,
        'language': _selectedLanguage,
        'dietaryPreference': _dietaryPreference ?? 'None / No preference',
        'restrictions': _restrictionsController.text.trim().isNotEmpty
            ? _restrictionsController.text.trim()
            : null,
        'completed': true,
        'timestamp': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );

      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final n = int.tryParse(v);
                  if (n == null || n < 13 || n > 120) return '13–120';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: _genders
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _gender = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        final n = double.tryParse(v);
                        if (n == null || n < 100 || n > 250)
                          return '100–250 cm';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Current Weight (kg)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        final n = double.tryParse(v);
                        if (n == null || n < 30 || n > 200) return '30–200 kg';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _targetWeightController,
                decoration: const InputDecoration(
                  labelText: 'Target Weight (kg) — optional',
                  border: OutlineInputBorder(),
                  helperText: 'Leave blank if not sure yet',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return null;
                  final n = double.tryParse(v);
                  if (n == null || n < 30 || n > 200) return 'Invalid weight';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _goal,
                decoration: const InputDecoration(
                  labelText: 'Main Goal',
                  border: OutlineInputBorder(),
                ),
                items: _goals
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _goal = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _activityLevel,
                decoration: const InputDecoration(
                  labelText: 'Activity Level',
                  border: OutlineInputBorder(),
                ),
                items: _activityLevels
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _activityLevel = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 24),

              DropdownButtonFormField<String>(
                value: _dietaryPreference,
                decoration: const InputDecoration(
                  labelText: 'Dietary Preference',
                  border: OutlineInputBorder(),
                ),
                items: _dietaryPreferences
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _dietaryPreference = v),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _restrictionsController,
                decoration: const InputDecoration(
                  labelText: 'Allergies, intolerances or medical conditions?',
                  border: OutlineInputBorder(),
                  helperText:
                      'E.g. lactose intolerant, diabetes, nut allergy… (optional)',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              Text(
                'How much guidance do you want?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                _confidence < 0.4
                    ? 'I know the basics'
                    : _confidence > 0.6
                    ? 'Guide me strictly'
                    : 'Somewhere in between',
              ),
              Slider(
                value: _confidence,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: (_confidence * 10).round().toString(),
                onChanged: (v) => setState(() => _confidence = v),
              ),
              const SizedBox(height: 24),

              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: const InputDecoration(
                  labelText: 'Preferred Language',
                  border: OutlineInputBorder(),
                ),
                items: _languages
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedLanguage = v!),
              ),
              const SizedBox(height: 40),

              FilledButton(
                onPressed: _saveSurvey,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: const Text('Save & Continue'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Skip → Manual Mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
