double calculateDailyTarget({
  required int age,
  required String gender,
  required double heightCm,
  required double weightKg,
  required String activityLevel,
  required String goal,
}) {
  // Mifflin-St Jeor BMR formula
  double bmr;
  if (gender.toLowerCase() == 'male' || gender.toLowerCase() == 'm') {
    bmr = 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
  } else {
    bmr = 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
  }

  // Activity level multiplier
  double multiplier = 1.2; // default sedentary
  final activityLower = activityLevel.toLowerCase();
  if (activityLower.contains('sedentary')) {
    multiplier = 1.2;
  } else if (activityLower.contains('lightly active') ||
      activityLower.contains('light')) {
    multiplier = 1.375;
  } else if (activityLower.contains('moderately active') ||
      activityLower.contains('moderate')) {
    multiplier = 1.55;
  } else if (activityLower.contains('very active') ||
      activityLower.contains('very')) {
    multiplier = 1.725;
  } else if (activityLower.contains('super active') ||
      activityLower.contains('super')) {
    multiplier = 1.9;
  }

  double maintenance = bmr * multiplier;

  // Goal adjustment (simple ±500 kcal)
  final goalLower = goal.toLowerCase();
  if (goalLower.contains('lose') || goalLower.contains('weight loss')) {
    return maintenance - 500; // ~0.5 kg/week loss
  } else if (goalLower.contains('gain') || goalLower.contains('muscle')) {
    return maintenance + 500; // ~0.5 kg/week gain
  } else {
    return maintenance.roundToDouble(); // maintain
  }
}
