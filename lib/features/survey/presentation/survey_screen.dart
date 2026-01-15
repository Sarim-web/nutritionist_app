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
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _restrictionsController = TextEditingController();

  String? _gender;
  String? _goal;
  String? _activityLevel;
  double _confidence = 0.5;
  String _selectedLanguage = 'English';
  String? _dietaryPreference;
  String? _selectedRegion;

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
    'Punjabi',
    'Arabic',
    'Hindi',
    'Spanish',
    'French',
    'German',
    'Indonesian',
    'Turkish',
  ];
  final List<String> _regions = [
    'Pakistan',
    'India',
    'Saudi Arabia',
    'United Arab Emirates',
    'United States',
    'United Kingdom',
    'Germany',
    'France',
    'Spain',
    'Indonesia',
    'Turkey',
    'Other',
  ];

  late Box _surveyBox;

  @override
  void initState() {
    super.initState();
    _openBoxAndLoadData();
  }

  Future<void> _openBoxAndLoadData() async {
    _surveyBox = await Hive.openBox('surveyBox');
    _loadExistingData();
  }

  void _loadExistingData() {
    final completed = _surveyBox.get('completed', defaultValue: false);
    if (completed) {
      _ageController.text = _surveyBox.get('age', defaultValue: 30).toString();
      _gender = _surveyBox.get('gender', defaultValue: 'Other');
      _heightController.text =
          _surveyBox.get('heightCm', defaultValue: 170.0).toString();
      _weightController.text =
          _surveyBox.get('weightKg', defaultValue: 70.0).toString();
      final target = _surveyBox.get('targetWeightKg');
      if (target != null) _targetWeightController.text = target.toString();
      _goal = _surveyBox.get('goal', defaultValue: 'Maintain weight');
      _activityLevel =
          _surveyBox.get('activityLevel', defaultValue: 'Sedentary');
      _confidence = _surveyBox.get('confidence', defaultValue: 0.5);
      _selectedLanguage = _surveyBox.get('language', defaultValue: 'English');
      _dietaryPreference = _surveyBox.get('dietaryPreference',
          defaultValue: 'None / No preference');
      _restrictionsController.text =
          _surveyBox.get('restrictions', defaultValue: '');
      _selectedRegion = _surveyBox.get('region', defaultValue: 'Other');
    }
    setState(() {});
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    _restrictionsController.dispose();
    super.dispose();
  }

  Future<bool> _confirmOverwrite() async {
    final alreadyCompleted = _surveyBox.get('completed', defaultValue: false);

    if (!alreadyCompleted) return true;

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Update Profile?'),
            content: const Text(
              'You already have a saved profile. Updating will replace the old information. Continue?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Update'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _saveSurvey() async {
    if (_formKey.currentState!.validate()) {
      final confirmed = await _confirmOverwrite();
      if (!confirmed) return;

      await _surveyBox.putAll({
        'age': int.tryParse(_ageController.text) ?? 30,
        'gender': _gender ?? 'Other',
        'heightCm': double.tryParse(_heightController.text) ?? 170.0,
        'weightKg': double.tryParse(_weightController.text) ?? 70.0,
        'targetWeightKg': double.tryParse(_targetWeightController.text),
        'goal': _goal ?? 'Maintain weight',
        'activityLevel': _activityLevel ?? 'Sedentary',
        'confidence': _confidence,
        'language': _selectedLanguage,
        'dietaryPreference': _dietaryPreference ?? 'None / No preference',
        'restrictions': _restrictionsController.text.trim().isNotEmpty
            ? _restrictionsController.text.trim()
            : null,
        'region': _selectedRegion ?? 'Other',
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
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
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
                            if (n == null || n < 30 || n > 200)
                              return '30–200 kg';
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
                      if (n == null || n < 30 || n > 200)
                        return 'Invalid weight';
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
                      labelText:
                          'Allergies, intolerances or medical conditions?',
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
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedRegion,
                    decoration: const InputDecoration(
                      labelText: 'Region / Country',
                      border: OutlineInputBorder(),
                      helperText:
                          'Helps show relevant local foods & suggestions',
                    ),
                    items: _regions
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedRegion = v),
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  const SizedBox(height: 40),
                  FilledButton(
                    onPressed: _saveSurvey,
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56)),
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
        ),
      ),
    );
  }
}
