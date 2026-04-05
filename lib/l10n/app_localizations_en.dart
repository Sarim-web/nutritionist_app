// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VitaCalo';

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
  String get remaining => 'Remaining';

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
      'You\'re using manual mode. Some features like calorie target are disabled.';

  @override
  String get logFoodButton => 'Log Food';

  @override
  String get switchToPersonalized => 'Switch to Personalized Mode';

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
  String get startFresh => 'Start Fresh';

  @override
  String get personalizeJourney => 'Personalize your journey';

  @override
  String get takeSurvey => 'Take Survey';

  @override
  String get continueManual => 'Continue in Manual Mode';

  @override
  String get foodAdded => 'Food added!';

  @override
  String get entryDeleted => 'Entry deleted';

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
  String get positiveNumber => 'Must be a positive number';

  @override
  String get positive => 'Must be positive';

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
  String get restrictions => 'Restrictions / Allergies';

  @override
  String get clearProfileTitle => 'Clear Profile?';

  @override
  String get clearProfileDesc =>
      'This will remove all your personal data and reset to manual mode.';

  @override
  String get clear => 'Clear';

  @override
  String get profileCleared => 'Profile cleared successfully';

  @override
  String ofTarget(Object kcal) {
    return 'of $kcal kcal';
  }

  @override
  String get kcalDay => 'kcal/day';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'of $kcal kcal';
  }

  @override
  String get takeSurveyDesc =>
      'Please complete your profile survey to get personalized insights.';

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
  String get restrictionsLabel => 'Restrictions / Allergies';

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
  String get profileSaved => 'Profile updated';

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

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get on => 'On';

  @override
  String get off => 'Off';

  @override
  String get language => 'Language';

  @override
  String get currentLanguage => 'Current Language';

  @override
  String get reminders => 'Reminders';

  @override
  String get dailyReminderDesc => 'Get daily calorie reminders';

  @override
  String get exportData => 'Export Data';

  @override
  String get backupYourData => 'Backup your logs and progress';

  @override
  String get importData => 'Import Data';

  @override
  String get restoreYourData => 'Restore your data from backup';

  @override
  String get aboutApp => 'About App';

  @override
  String get aboutDesc =>
      'Offline calorie tracker with local foods and privacy focus';

  @override
  String get manageProfiles => 'Manage Profiles';

  @override
  String get switchProfile => 'Switch Profile';

  @override
  String get noProfilesYet => 'No profiles yet';

  @override
  String get createNewProfile => 'Create New Profile';

  @override
  String get profileName => 'Profile Name';

  @override
  String get profileNameHint => 'e.g. Family Member 1';

  @override
  String get create => 'Create';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get switchedTo => 'Switched to';

  @override
  String get createdProfile => 'Created profile';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProfile => 'Delete Profile';

  @override
  String get deleteProfileDesc =>
      'This will permanently delete all data for this profile. This action cannot be undone.';

  @override
  String get profileDeleted => 'Profile deleted';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectWeightUnit => 'Select Weight Unit';

  @override
  String get selectHeightUnit => 'Select Height Unit';

  @override
  String get weightUnit => 'Weight Unit';

  @override
  String get heightUnit => 'Height Unit';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get rateUs => 'Rate Us';

  @override
  String get rateUsComingSoon => 'Rate Us feature coming soon!';

  @override
  String get joinBeta => 'Join Beta Testing';

  @override
  String get betaComingSoon => 'Beta Testing program coming soon!';

  @override
  String get todayCalories => 'Today\'s Calories';

  @override
  String get manualEntry => 'Manual Entry';

  @override
  String get failedToCreateProfile => 'Failed to create profile';

  @override
  String get failedToDeleteProfile => 'Failed to delete profile';

  @override
  String get foodLogged => 'Food logged successfully';

  @override
  String get historyAndProgress => 'History & Progress';

  @override
  String get height => 'Height';

  @override
  String get currentWeight => 'Current Weight';

  @override
  String get checkingConnection => 'Checking connection...';

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get pleaseConnectToInternet =>
      'Please connect to the internet to continue';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get trackNutrition => 'Track Your Nutrition';

  @override
  String get trackNutritionDesc =>
      'Easily log meals and monitor calories with region-specific foods';

  @override
  String get trackProgress => 'Track Your Progress';

  @override
  String get trackProgressDesc =>
      'View charts and history of your daily calorie intake and goals';

  @override
  String get personalizedProfile => 'Personalized Profile';

  @override
  String get personalizedProfileDesc =>
      'Create multiple profiles for family members with customized recommendations';

  @override
  String get getStarted => 'Get Started';

  @override
  String get profileSwitchedTitle => 'Profile Switched';

  @override
  String get profileSwitchedDesc =>
      'The app needs to restart to fully apply the new profile. Restart now?';

  @override
  String get later => 'Later';

  @override
  String get restartNow => 'Restart Now';
}
