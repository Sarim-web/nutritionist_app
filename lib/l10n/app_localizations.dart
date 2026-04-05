import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur'),
    Locale('ar'),
    Locale('de'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('pa'),
    Locale('tr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VitaCalo'**
  String get appTitle;

  /// No description provided for @logFood.
  ///
  /// In en, this message translates to:
  /// **'Log Food'**
  String get logFood;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @yourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your Profile'**
  String get yourProfile;

  /// No description provided for @commonFoods.
  ///
  /// In en, this message translates to:
  /// **'Common Foods'**
  String get commonFoods;

  /// No description provided for @searchFoods.
  ///
  /// In en, this message translates to:
  /// **'Search foods...'**
  String get searchFoods;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today: {kcal} kcal'**
  String today(Object kcal);

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @newDayMessage.
  ///
  /// In en, this message translates to:
  /// **'New day started — calories reset to 0'**
  String get newDayMessage;

  /// No description provided for @loggedToday.
  ///
  /// In en, this message translates to:
  /// **'Logged Today'**
  String get loggedToday;

  /// No description provided for @noFoodToday.
  ///
  /// In en, this message translates to:
  /// **'No food logged today yet'**
  String get noFoodToday;

  /// No description provided for @addFood.
  ///
  /// In en, this message translates to:
  /// **'Add Food'**
  String get addFood;

  /// No description provided for @foodName.
  ///
  /// In en, this message translates to:
  /// **'Food Name'**
  String get foodName;

  /// No description provided for @caloriesPerServing.
  ///
  /// In en, this message translates to:
  /// **'Calories (per serving)'**
  String get caloriesPerServing;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @mealCategory.
  ///
  /// In en, this message translates to:
  /// **'Meal Category'**
  String get mealCategory;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @manualModeActive.
  ///
  /// In en, this message translates to:
  /// **'Manual Mode Active'**
  String get manualModeActive;

  /// No description provided for @manualModeDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'re using manual mode. Some features like calorie target are disabled.'**
  String get manualModeDesc;

  /// No description provided for @logFoodButton.
  ///
  /// In en, this message translates to:
  /// **'Log Food'**
  String get logFoodButton;

  /// No description provided for @switchToPersonalized.
  ///
  /// In en, this message translates to:
  /// **'Switch to Personalized Mode'**
  String get switchToPersonalized;

  /// No description provided for @dailyProgress.
  ///
  /// In en, this message translates to:
  /// **'Daily Progress'**
  String get dailyProgress;

  /// No description provided for @goodPace.
  ///
  /// In en, this message translates to:
  /// **'Good pace — keep going!'**
  String get goodPace;

  /// No description provided for @almostThere.
  ///
  /// In en, this message translates to:
  /// **'Almost there — stay mindful'**
  String get almostThere;

  /// No description provided for @overTarget.
  ///
  /// In en, this message translates to:
  /// **'Over target — consider lighter choices'**
  String get overTarget;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @startFresh.
  ///
  /// In en, this message translates to:
  /// **'Start Fresh'**
  String get startFresh;

  /// No description provided for @personalizeJourney.
  ///
  /// In en, this message translates to:
  /// **'Personalize your journey'**
  String get personalizeJourney;

  /// No description provided for @takeSurvey.
  ///
  /// In en, this message translates to:
  /// **'Take Survey'**
  String get takeSurvey;

  /// No description provided for @continueManual.
  ///
  /// In en, this message translates to:
  /// **'Continue in Manual Mode'**
  String get continueManual;

  /// No description provided for @foodAdded.
  ///
  /// In en, this message translates to:
  /// **'Food added!'**
  String get foodAdded;

  /// No description provided for @entryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Entry deleted'**
  String get entryDeleted;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get snack;

  /// No description provided for @fruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get fruit;

  /// No description provided for @dessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get dessert;

  /// No description provided for @drink.
  ///
  /// In en, this message translates to:
  /// **'Drink'**
  String get drink;

  /// No description provided for @allRegions.
  ///
  /// In en, this message translates to:
  /// **'All Regions'**
  String get allRegions;

  /// No description provided for @pakistan.
  ///
  /// In en, this message translates to:
  /// **'Pakistan'**
  String get pakistan;

  /// No description provided for @india.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get india;

  /// No description provided for @saudiArabia.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get saudiArabia;

  /// No description provided for @uae.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get uae;

  /// No description provided for @usa.
  ///
  /// In en, this message translates to:
  /// **'USA'**
  String get usa;

  /// No description provided for @uk.
  ///
  /// In en, this message translates to:
  /// **'UK'**
  String get uk;

  /// No description provided for @germany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get germany;

  /// No description provided for @france.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get france;

  /// No description provided for @spain.
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get spain;

  /// No description provided for @indonesia.
  ///
  /// In en, this message translates to:
  /// **'Indonesia'**
  String get indonesia;

  /// No description provided for @turkey.
  ///
  /// In en, this message translates to:
  /// **'Turkey'**
  String get turkey;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @positiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Must be a positive number'**
  String get positiveNumber;

  /// No description provided for @positive.
  ///
  /// In en, this message translates to:
  /// **'Must be positive'**
  String get positive;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @kcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get kcal;

  /// No description provided for @caloriesHelper.
  ///
  /// In en, this message translates to:
  /// **'Estimate is fine — use chips above'**
  String get caloriesHelper;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @targetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target Weight'**
  String get targetWeight;

  /// No description provided for @dietaryPreference.
  ///
  /// In en, this message translates to:
  /// **'Dietary Preference'**
  String get dietaryPreference;

  /// No description provided for @restrictions.
  ///
  /// In en, this message translates to:
  /// **'Restrictions / Allergies'**
  String get restrictions;

  /// No description provided for @clearProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Profile?'**
  String get clearProfileTitle;

  /// No description provided for @clearProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'This will remove all your personal data and reset to manual mode.'**
  String get clearProfileDesc;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @profileCleared.
  ///
  /// In en, this message translates to:
  /// **'Profile cleared successfully'**
  String get profileCleared;

  /// No description provided for @ofTarget.
  ///
  /// In en, this message translates to:
  /// **'of {kcal} kcal'**
  String ofTarget(Object kcal);

  /// No description provided for @kcalDay.
  ///
  /// In en, this message translates to:
  /// **'kcal/day'**
  String get kcalDay;

  /// No description provided for @dailyTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'of {kcal} kcal'**
  String dailyTargetLabel(Object kcal);

  /// No description provided for @takeSurveyDesc.
  ///
  /// In en, this message translates to:
  /// **'Please complete your profile survey to get personalized insights.'**
  String get takeSurveyDesc;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @heightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightCm;

  /// No description provided for @currentWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Current Weight (kg)'**
  String get currentWeightKg;

  /// No description provided for @targetWeightKgOptional.
  ///
  /// In en, this message translates to:
  /// **'Target Weight (kg) — optional'**
  String get targetWeightKgOptional;

  /// No description provided for @targetWeightHelper.
  ///
  /// In en, this message translates to:
  /// **'Leave blank if not sure yet'**
  String get targetWeightHelper;

  /// No description provided for @mainGoal.
  ///
  /// In en, this message translates to:
  /// **'Main Goal'**
  String get mainGoal;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level'**
  String get activityLevel;

  /// No description provided for @restrictionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Restrictions / Allergies'**
  String get restrictionsLabel;

  /// No description provided for @restrictionsHelper.
  ///
  /// In en, this message translates to:
  /// **'E.g. lactose intolerant, diabetes, nut allergy… (optional)'**
  String get restrictionsHelper;

  /// No description provided for @guidanceQuestion.
  ///
  /// In en, this message translates to:
  /// **'How much guidance do you want?'**
  String get guidanceQuestion;

  /// No description provided for @guidanceLow.
  ///
  /// In en, this message translates to:
  /// **'I know the basics'**
  String get guidanceLow;

  /// No description provided for @guidanceMedium.
  ///
  /// In en, this message translates to:
  /// **'Somewhere in between'**
  String get guidanceMedium;

  /// No description provided for @guidanceHigh.
  ///
  /// In en, this message translates to:
  /// **'Guide me strictly'**
  String get guidanceHigh;

  /// No description provided for @regionCountry.
  ///
  /// In en, this message translates to:
  /// **'Region / Country'**
  String get regionCountry;

  /// No description provided for @regionHelper.
  ///
  /// In en, this message translates to:
  /// **'Helps show relevant local foods & suggestions'**
  String get regionHelper;

  /// No description provided for @saveContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get saveContinue;

  /// No description provided for @skipManual.
  ///
  /// In en, this message translates to:
  /// **'Skip → Manual Mode'**
  String get skipManual;

  /// No description provided for @updateProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Profile?'**
  String get updateProfileTitle;

  /// No description provided for @updateProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'You already have a saved profile. Updating will replace the old information. Continue?'**
  String get updateProfileDesc;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileSaved;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get basicInfo;

  /// No description provided for @goalsAndLifestyle.
  ///
  /// In en, this message translates to:
  /// **'Goals & Lifestyle'**
  String get goalsAndLifestyle;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @currentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Current Language'**
  String get currentLanguage;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @dailyReminderDesc.
  ///
  /// In en, this message translates to:
  /// **'Get daily calorie reminders'**
  String get dailyReminderDesc;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @backupYourData.
  ///
  /// In en, this message translates to:
  /// **'Backup your logs and progress'**
  String get backupYourData;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importData;

  /// No description provided for @restoreYourData.
  ///
  /// In en, this message translates to:
  /// **'Restore your data from backup'**
  String get restoreYourData;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @aboutDesc.
  ///
  /// In en, this message translates to:
  /// **'Offline calorie tracker with local foods and privacy focus'**
  String get aboutDesc;

  /// No description provided for @manageProfiles.
  ///
  /// In en, this message translates to:
  /// **'Manage Profiles'**
  String get manageProfiles;

  /// No description provided for @switchProfile.
  ///
  /// In en, this message translates to:
  /// **'Switch Profile'**
  String get switchProfile;

  /// No description provided for @noProfilesYet.
  ///
  /// In en, this message translates to:
  /// **'No profiles yet'**
  String get noProfilesYet;

  /// No description provided for @createNewProfile.
  ///
  /// In en, this message translates to:
  /// **'Create New Profile'**
  String get createNewProfile;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Profile Name'**
  String get profileName;

  /// No description provided for @profileNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Family Member 1'**
  String get profileNameHint;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @switchedTo.
  ///
  /// In en, this message translates to:
  /// **'Switched to'**
  String get switchedTo;

  /// No description provided for @createdProfile.
  ///
  /// In en, this message translates to:
  /// **'Created profile'**
  String get createdProfile;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile'**
  String get deleteProfile;

  /// No description provided for @deleteProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all data for this profile. This action cannot be undone.'**
  String get deleteProfileDesc;

  /// No description provided for @profileDeleted.
  ///
  /// In en, this message translates to:
  /// **'Profile deleted'**
  String get profileDeleted;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectWeightUnit.
  ///
  /// In en, this message translates to:
  /// **'Select Weight Unit'**
  String get selectWeightUnit;

  /// No description provided for @selectHeightUnit.
  ///
  /// In en, this message translates to:
  /// **'Select Height Unit'**
  String get selectHeightUnit;

  /// No description provided for @weightUnit.
  ///
  /// In en, this message translates to:
  /// **'Weight Unit'**
  String get weightUnit;

  /// No description provided for @heightUnit.
  ///
  /// In en, this message translates to:
  /// **'Height Unit'**
  String get heightUnit;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @rateUsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Rate Us feature coming soon!'**
  String get rateUsComingSoon;

  /// No description provided for @joinBeta.
  ///
  /// In en, this message translates to:
  /// **'Join Beta Testing'**
  String get joinBeta;

  /// No description provided for @betaComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Beta Testing program coming soon!'**
  String get betaComingSoon;

  /// No description provided for @todayCalories.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Calories'**
  String get todayCalories;

  /// No description provided for @manualEntry.
  ///
  /// In en, this message translates to:
  /// **'Manual Entry'**
  String get manualEntry;

  /// No description provided for @failedToCreateProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to create profile'**
  String get failedToCreateProfile;

  /// No description provided for @failedToDeleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete profile'**
  String get failedToDeleteProfile;

  /// No description provided for @foodLogged.
  ///
  /// In en, this message translates to:
  /// **'Food logged successfully'**
  String get foodLogged;

  /// No description provided for @historyAndProgress.
  ///
  /// In en, this message translates to:
  /// **'History & Progress'**
  String get historyAndProgress;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @currentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current Weight'**
  String get currentWeight;

  /// No description provided for @checkingConnection.
  ///
  /// In en, this message translates to:
  /// **'Checking connection...'**
  String get checkingConnection;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnection;

  /// No description provided for @pleaseConnectToInternet.
  ///
  /// In en, this message translates to:
  /// **'Please connect to the internet to continue'**
  String get pleaseConnectToInternet;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @trackNutrition.
  ///
  /// In en, this message translates to:
  /// **'Track Your Nutrition'**
  String get trackNutrition;

  /// No description provided for @trackNutritionDesc.
  ///
  /// In en, this message translates to:
  /// **'Easily log meals and monitor calories with region-specific foods'**
  String get trackNutritionDesc;

  /// No description provided for @trackProgress.
  ///
  /// In en, this message translates to:
  /// **'Track Your Progress'**
  String get trackProgress;

  /// No description provided for @trackProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'View charts and history of your daily calorie intake and goals'**
  String get trackProgressDesc;

  /// No description provided for @personalizedProfile.
  ///
  /// In en, this message translates to:
  /// **'Personalized Profile'**
  String get personalizedProfile;

  /// No description provided for @personalizedProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'Create multiple profiles for family members with customized recommendations'**
  String get personalizedProfileDesc;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @profileSwitchedTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Switched'**
  String get profileSwitchedTitle;

  /// No description provided for @profileSwitchedDesc.
  ///
  /// In en, this message translates to:
  /// **'The app needs to restart to fully apply the new profile. Restart now?'**
  String get profileSwitchedDesc;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @restartNow.
  ///
  /// In en, this message translates to:
  /// **'Restart Now'**
  String get restartNow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'pa',
        'tr',
        'ur'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'pa':
      return AppLocalizationsPa();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
