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
  /// **'Nutritionist'**
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
  /// **'Remaining: {kcal} kcal'**
  String remaining(Object kcal);

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
  /// **'You are tracking calories without a personalized goal.\nLog foods freely — you can take the survey anytime for custom targets.'**
  String get manualModeDesc;

  /// No description provided for @logFoodButton.
  ///
  /// In en, this message translates to:
  /// **'Log Food'**
  String get logFoodButton;

  /// No description provided for @switchToPersonalized.
  ///
  /// In en, this message translates to:
  /// **'Switch to Personalized Mode (Take Survey)'**
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
  /// **'Start Fresh (Clear Profile)'**
  String get startFresh;

  /// No description provided for @personalizeJourney.
  ///
  /// In en, this message translates to:
  /// **'Personalize your journey'**
  String get personalizeJourney;

  /// No description provided for @takeSurvey.
  ///
  /// In en, this message translates to:
  /// **'Take Profile Survey'**
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
  /// **'Positive number'**
  String get positiveNumber;

  /// No description provided for @positive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get positive;

  /// No description provided for @entryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Entry deleted'**
  String get entryDeleted;

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
  /// **'Restrictions'**
  String get restrictions;

  /// No description provided for @clearProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Profile?'**
  String get clearProfileTitle;

  /// No description provided for @clearProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'This will remove all saved profile info and calorie logs. You can take the survey again for a fresh start.'**
  String get clearProfileDesc;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @profileCleared.
  ///
  /// In en, this message translates to:
  /// **'Profile and logs cleared'**
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

  /// No description provided for @takeSurveyDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete the quick profile to get a custom calorie goal and better recommendations.'**
  String get takeSurveyDesc;

  /// No description provided for @dailyTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'of {kcal} kcal'**
  String dailyTargetLabel(Object kcal);

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
  /// **'Allergies, intolerances or medical conditions?'**
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
  /// **'Profile saved successfully'**
  String get profileSaved;
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
