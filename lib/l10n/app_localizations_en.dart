// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nutritionist';

  @override
  String get logFood => 'Log Food';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get yourProfile => 'Your Profile';

  @override
  String get commonFoods => 'Common Foods';

  @override
  String get searchFoods => 'Search foods...';

  @override
  String today(Object kcal) {
    return 'Today: $kcal kcal';
  }

  @override
  String remaining(Object kcal) {
    return 'Remaining: $kcal kcal';
  }

  @override
  String get newDayMessage => 'New day started — calories reset to 0';

  @override
  String get loggedToday => 'Logged Today';

  @override
  String get noFoodToday => 'No food logged today yet';

  @override
  String get addFood => 'Add Food';

  @override
  String get foodName => 'Food Name';

  @override
  String get caloriesPerServing => 'Calories (per serving)';

  @override
  String get quantity => 'Quantity';

  @override
  String get mealCategory => 'Meal Category';

  @override
  String get done => 'Done';

  @override
  String get manualModeActive => 'Manual Mode Active';

  @override
  String get manualModeDesc =>
      'You are tracking calories without a personalized goal.\nLog foods freely — you can take the survey anytime for custom targets.';

  @override
  String get logFoodButton => 'Log Food';

  @override
  String get switchToPersonalized =>
      'Switch to Personalized Mode (Take Survey)';

  @override
  String get dailyProgress => 'Daily Progress';

  @override
  String get goodPace => 'Good pace — keep going!';

  @override
  String get almostThere => 'Almost there — stay mindful';

  @override
  String get overTarget => 'Over target — consider lighter choices';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get startFresh => 'Start Fresh (Clear Profile)';

  @override
  String get personalizeJourney => 'Personalize your journey';

  @override
  String get takeSurvey => 'Take Profile Survey';

  @override
  String get continueManual => 'Continue in Manual Mode';

  @override
  String get foodAdded => 'Food added!';

  @override
  String get all => 'All';

  @override
  String get breakfast => 'Breakfast';

  @override
  String get lunch => 'Lunch';

  @override
  String get dinner => 'Dinner';

  @override
  String get snack => 'Snack';

  @override
  String get fruit => 'Fruit';

  @override
  String get dessert => 'Dessert';

  @override
  String get drink => 'Drink';

  @override
  String get allRegions => 'All Regions';

  @override
  String get pakistan => 'Pakistan';

  @override
  String get india => 'India';

  @override
  String get saudiArabia => 'Saudi Arabia';

  @override
  String get uae => 'UAE';

  @override
  String get usa => 'USA';

  @override
  String get uk => 'UK';

  @override
  String get germany => 'Germany';

  @override
  String get france => 'France';

  @override
  String get spain => 'Spain';

  @override
  String get indonesia => 'Indonesia';

  @override
  String get turkey => 'Turkey';

  @override
  String get required => 'Required';

  @override
  String get positiveNumber => 'Positive number';

  @override
  String get positive => 'Positive';

  @override
  String get entryDeleted => 'Entry deleted';

  @override
  String get unknown => 'Unknown';

  @override
  String get kcal => 'kcal';

  @override
  String get caloriesHelper => 'Estimate is fine — use chips above';

  @override
  String get target => 'Target';

  @override
  String get goal => 'Goal';

  @override
  String get activity => 'Activity';

  @override
  String get targetWeight => 'Target Weight';

  @override
  String get dietaryPreference => 'Dietary Preference';

  @override
  String get restrictions => 'Restrictions';

  @override
  String get clearProfileTitle => 'Clear Profile?';

  @override
  String get clearProfileDesc =>
      'This will remove all saved profile info and calorie logs. You can take the survey again for a fresh start.';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get profileCleared => 'Profile and logs cleared';

  @override
  String ofTarget(Object kcal) {
    return 'of $kcal kcal';
  }

  @override
  String get kcalDay => 'kcal/day';

  @override
  String get takeSurveyDesc =>
      'Complete the quick profile to get a custom calorie goal and better recommendations.';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'of $kcal kcal';
  }

  @override
  String get age => 'Age';

  @override
  String get gender => 'Gender';

  @override
  String get heightCm => 'Height (cm)';

  @override
  String get currentWeightKg => 'Current Weight (kg)';

  @override
  String get targetWeightKgOptional => 'Target Weight (kg) — optional';

  @override
  String get targetWeightHelper => 'Leave blank if not sure yet';

  @override
  String get mainGoal => 'Main Goal';

  @override
  String get activityLevel => 'Activity Level';

  @override
  String get restrictionsLabel =>
      'Allergies, intolerances or medical conditions?';

  @override
  String get restrictionsHelper =>
      'E.g. lactose intolerant, diabetes, nut allergy… (optional)';

  @override
  String get guidanceQuestion => 'How much guidance do you want?';

  @override
  String get guidanceLow => 'I know the basics';

  @override
  String get guidanceMedium => 'Somewhere in between';

  @override
  String get guidanceHigh => 'Guide me strictly';

  @override
  String get regionCountry => 'Region / Country';

  @override
  String get regionHelper => 'Helps show relevant local foods & suggestions';

  @override
  String get saveContinue => 'Save & Continue';

  @override
  String get skipManual => 'Skip → Manual Mode';

  @override
  String get updateProfileTitle => 'Update Profile?';

  @override
  String get updateProfileDesc =>
      'You already have a saved profile. Updating will replace the old information. Continue?';

  @override
  String get update => 'Update';

  @override
  String get profileSaved => 'Profile saved successfully';

  @override
  String get basicInfo => 'Basic Info';

  @override
  String get goalsAndLifestyle => 'Goals & Lifestyle';

  @override
  String get preferences => 'Preferences';

  @override
  String get location => 'Location';

  @override
  String get next => 'Next';
}
