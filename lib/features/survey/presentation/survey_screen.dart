import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../l10n/app_localizations.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(4, (_) => GlobalKey<FormState>());

  // ──────────────────────────────────────────────
  // Your existing fields (copy-paste from your old version)
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _restrictionsController = TextEditingController();

  String? _gender;
  String? _goal;
  String? _activityLevel;
  double _confidence = 0.5;
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

    final l10n = AppLocalizations.of(context)!;

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.updateProfileTitle),
            content: Text(l10n.updateProfileDesc),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.update),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _saveSurvey() async {
    // Final validation (optional: check all forms again)
    bool isValid = true;
    for (var key in _formKeys) {
      if (key.currentState != null && !key.currentState!.validate()) {
        isValid = false;
      }
    }
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!.required ??
                'Please complete all required fields')),
      );
      return;
    }

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
      'dietaryPreference': _dietaryPreference ?? 'None / No preference',
      'restrictions': _restrictionsController.text.trim().isNotEmpty
          ? _restrictionsController.text.trim()
          : null,
      'region': _selectedRegion ?? 'Other',
      'completed': true,
      'timestamp': DateTime.now().toIso8601String(),
    });

    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.profileSaved)),
    );

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.yourProfile),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          final form = _formKeys[_currentStep].currentState;
          if (form != null && form.validate()) {
            if (_currentStep < 3) {
              setState(() => _currentStep += 1);
            } else {
              _saveSurvey();
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(l10n.required ?? 'Please fill required fields')),
            );
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            context.pop();
          }
        },
        steps: [
          // Step 1: Personal Basics
          Step(
            title: Text('Personal Basics'),
            content: Form(
              key: _formKeys[0],
              child: Column(
                children: [
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(labelText: l10n.age),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return l10n.required;
                      final n = int.tryParse(v);
                      if (n == null || n < 8 || n > 100) return '8–100';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: InputDecoration(labelText: l10n.gender),
                    items: _genders
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _gender = v),
                    validator: (v) => v == null ? l10n.required : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _heightController,
                    decoration: InputDecoration(labelText: l10n.heightCm),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return l10n.required;
                      final n = double.tryParse(v);
                      if (n == null || n < 100 || n > 250) return '100–250 cm';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _weightController,
                    decoration:
                        InputDecoration(labelText: l10n.currentWeightKg),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return l10n.required;
                      final n = double.tryParse(v);
                      if (n == null || n < 30 || n > 200) return '30–200 kg';
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),

          // Step 2: Goals & Activity
          Step(
            title: Text('Goals & Activity'),
            content: Form(
              key: _formKeys[1],
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _goal,
                    decoration: InputDecoration(labelText: l10n.mainGoal),
                    items: _goals
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _goal = v),
                    validator: (v) => v == null ? l10n.required : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _activityLevel,
                    decoration: InputDecoration(labelText: l10n.activityLevel),
                    items: _activityLevels
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _activityLevel = v),
                    validator: (v) => v == null ? l10n.required : null,
                  ),
                  const SizedBox(height: 24),
                  Text(l10n.guidanceQuestion),
                  Slider(
                    value: _confidence,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: (_confidence * 10).round().toString(),
                    onChanged: (v) => setState(() => _confidence = v),
                  ),
                  Text(
                    _confidence < 0.4
                        ? l10n.guidanceLow
                        : _confidence > 0.6
                            ? l10n.guidanceHigh
                            : l10n.guidanceMedium,
                  ),
                ],
              ),
            ),
          ),

          // Step 3: Preferences
          Step(
            title: Text('Preferences'),
            content: Form(
              key: _formKeys[2],
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _dietaryPreference,
                    decoration:
                        InputDecoration(labelText: l10n.dietaryPreference),
                    items: _dietaryPreferences
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _dietaryPreference = v),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _restrictionsController,
                    decoration: InputDecoration(
                      labelText: l10n.restrictionsLabel,
                      helperText: l10n.restrictionsHelper,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),

          // Step 4: Region & Target
          Step(
            title: Text('Region & Target'),
            content: Form(
              key: _formKeys[3],
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedRegion,
                    decoration: InputDecoration(
                      labelText: l10n.regionCountry,
                      helperText: l10n.regionHelper,
                    ),
                    items: _regions
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedRegion = v),
                    validator: (v) => v == null ? l10n.required : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _targetWeightController,
                    decoration: InputDecoration(
                      labelText: l10n.targetWeightKgOptional,
                      helperText: l10n.targetWeightHelper,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
