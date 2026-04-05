// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'VitaCalo';

  @override
  String get logFood => 'Essen protokollieren';

  @override
  String get dashboard => 'Übersicht';

  @override
  String get yourProfile => 'Dein Profil';

  @override
  String get commonFoods => 'Häufige Lebensmittel';

  @override
  String get searchFoods => 'Lebensmittel suchen...';

  @override
  String today(Object kcal) {
    return 'Heute: $kcal kcal';
  }

  @override
  String get remaining => 'Verbleibend';

  @override
  String get newDayMessage =>
      'Neuer Tag gestartet — Kalorien auf 0 zurückgesetzt';

  @override
  String get loggedToday => 'Heute protokolliert';

  @override
  String get noFoodToday =>
      'Heute wurden noch keine Lebensmittel protokolliert';

  @override
  String get addFood => 'Essen hinzufügen';

  @override
  String get foodName => 'Name des Lebensmittels';

  @override
  String get caloriesPerServing => 'Kalorien (pro Portion)';

  @override
  String get quantity => 'Menge';

  @override
  String get mealCategory => 'Mahlzeitenkategorie';

  @override
  String get done => 'Fertig';

  @override
  String get manualModeActive => 'Manueller Modus aktiv';

  @override
  String get manualModeDesc =>
      'Du verwendest den manuellen Modus. Einige Funktionen wie das Kalorienziel sind deaktiviert.';

  @override
  String get logFoodButton => 'Essen protokollieren';

  @override
  String get switchToPersonalized => 'Zum personalisierten Modus wechseln';

  @override
  String get dailyProgress => 'Täglicher Fortschritt';

  @override
  String get goodPace => 'Gutes Tempo — weiter so!';

  @override
  String get almostThere => 'Fast geschafft — bleiben Sie achtsam';

  @override
  String get overTarget =>
      'Über dem Ziel — leichtere Optionen in Betracht ziehen';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get startFresh => 'Neu beginnen';

  @override
  String get personalizeJourney => 'Gestalten Sie Ihre Reise individuell';

  @override
  String get takeSurvey => 'Umfrage starten';

  @override
  String get continueManual => 'Im manuellen Modus fortfahren';

  @override
  String get foodAdded => 'Lebensmittel hinzugefügt!';

  @override
  String get entryDeleted => 'Eintrag gelöscht';

  @override
  String get all => 'Alle';

  @override
  String get breakfast => 'Frühstück';

  @override
  String get lunch => 'Mittagessen';

  @override
  String get dinner => 'Abendessen';

  @override
  String get snack => 'Snack';

  @override
  String get fruit => 'Obst';

  @override
  String get dessert => 'Dessert';

  @override
  String get drink => 'Getränk';

  @override
  String get allRegions => 'Alle Regionen';

  @override
  String get pakistan => 'Pakistan';

  @override
  String get india => 'Indien';

  @override
  String get saudiArabia => 'Saudi-Arabien';

  @override
  String get uae => 'Vereinigte Arabische Emirate';

  @override
  String get usa => 'USA';

  @override
  String get uk => 'Vereinigtes Königreich';

  @override
  String get germany => 'Deutschland';

  @override
  String get france => 'Frankreich';

  @override
  String get spain => 'Spanien';

  @override
  String get indonesia => 'Indonesien';

  @override
  String get turkey => 'Türkei';

  @override
  String get required => 'Erforderlich';

  @override
  String get positiveNumber => 'Muss eine positive Zahl sein';

  @override
  String get positive => 'Muss positiv sein';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get kcal => 'kcal';

  @override
  String get caloriesHelper =>
      'Eine Schätzung ist ausreichend — verwenden Sie die Auswahl oben';

  @override
  String get target => 'Ziel';

  @override
  String get goal => 'Zielsetzung';

  @override
  String get activity => 'Aktivität';

  @override
  String get targetWeight => 'Zielgewicht';

  @override
  String get dietaryPreference => 'Ernährungspräferenz';

  @override
  String get restrictions => 'Einschränkungen / Allergien';

  @override
  String get clearProfileTitle => 'Profil löschen?';

  @override
  String get clearProfileDesc =>
      'Dies löscht alle persönlichen Daten und setzt den manuellen Modus zurück.';

  @override
  String get clear => 'Löschen';

  @override
  String get profileCleared => 'Profil erfolgreich gelöscht';

  @override
  String ofTarget(Object kcal) {
    return 'von $kcal kcal';
  }

  @override
  String get kcalDay => 'kcal/Tag';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'von $kcal kcal';
  }

  @override
  String get takeSurveyDesc =>
      'Bitte fülle die Profilumfrage aus, um personalisierte Einblicke zu erhalten.';

  @override
  String get age => 'Alter';

  @override
  String get gender => 'Geschlecht';

  @override
  String get heightCm => 'Größe (cm)';

  @override
  String get currentWeightKg => 'Aktuelles Gewicht (kg)';

  @override
  String get targetWeightKgOptional => 'Zielgewicht (kg) — optional';

  @override
  String get targetWeightHelper => 'Leer lassen, falls Sie noch unsicher sind';

  @override
  String get mainGoal => 'Hauptziel';

  @override
  String get activityLevel => 'Aktivitätslevel';

  @override
  String get restrictionsLabel => 'Einschränkungen / Allergien';

  @override
  String get restrictionsHelper =>
      'Z. B. Laktoseintoleranz, Diabetes, Nussallergie… (optional)';

  @override
  String get guidanceQuestion => 'Wie viel Anleitung wünschen Sie sich?';

  @override
  String get guidanceLow => 'Ich kenne die Grundlagen';

  @override
  String get guidanceMedium => 'Irgendwo dazwischen';

  @override
  String get guidanceHigh => 'Bitte streng anleiten';

  @override
  String get regionCountry => 'Region / Land';

  @override
  String get regionHelper =>
      'Hilft, relevante lokale Lebensmittel und Vorschläge anzuzeigen';

  @override
  String get saveContinue => 'Speichern & fortfahren';

  @override
  String get skipManual => 'Überspringen → Manueller Modus';

  @override
  String get updateProfileTitle => 'Profil aktualisieren?';

  @override
  String get updateProfileDesc =>
      'Sie haben bereits ein gespeichertes Profil. Durch die Aktualisierung werden die alten Informationen ersetzt. Fortfahren?';

  @override
  String get update => 'Aktualisieren';

  @override
  String get profileSaved => 'Profil aktualisiert';

  @override
  String get basicInfo => 'Grundinformationen';

  @override
  String get goalsAndLifestyle => 'Ziele und Lebensstil';

  @override
  String get preferences => 'Einstellungen';

  @override
  String get location => 'Standort';

  @override
  String get next => 'Weiter';

  @override
  String get settings => 'Einstellungen';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get on => 'Ein';

  @override
  String get off => 'Aus';

  @override
  String get language => 'Sprache';

  @override
  String get currentLanguage => 'Aktuelle Sprache';

  @override
  String get reminders => 'Erinnerungen';

  @override
  String get dailyReminderDesc => 'Tägliche Kalorien-Erinnerungen erhalten';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get backupYourData => 'Sichern Sie Ihre Logs und Ihren Fortschritt';

  @override
  String get importData => 'Daten importieren';

  @override
  String get restoreYourData => 'Daten aus Backup wiederherstellen';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get aboutDesc =>
      'Offline-Kalorien-Tracker mit lokalen Lebensmitteln und Datenschutz-Fokus';

  @override
  String get manageProfiles => 'Profile verwalten';

  @override
  String get switchProfile => 'Profil wechseln';

  @override
  String get noProfilesYet => 'Noch keine Profile';

  @override
  String get createNewProfile => 'Neues Profil erstellen';

  @override
  String get profileName => 'Profilname';

  @override
  String get profileNameHint => 'z. B. Familienmitglied 1';

  @override
  String get create => 'Erstellen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get switchedTo => 'Gewechselt zu';

  @override
  String get createdProfile => 'Profil erstellt';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProfile => 'Profil löschen';

  @override
  String get deleteProfileDesc =>
      'Dadurch werden alle Daten dieses Profils dauerhaft gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get profileDeleted => 'Profil gelöscht';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get selectWeightUnit => 'Gewichtseinheit auswählen';

  @override
  String get selectHeightUnit => 'Höheneinheit auswählen';

  @override
  String get weightUnit => 'Gewichtseinheit';

  @override
  String get heightUnit => 'Höheneinheit';

  @override
  String get comingSoon => 'Bald verfügbar';

  @override
  String get rateUs => 'Bewerten Sie uns';

  @override
  String get rateUsComingSoon => 'Die Bewertungsfunktion kommt bald!';

  @override
  String get joinBeta => 'Beta-Tests beitreten';

  @override
  String get betaComingSoon => 'Das Beta-Test-Programm kommt bald!';

  @override
  String get todayCalories => 'Heutige Kalorien';

  @override
  String get manualEntry => 'Manuelle Eingabe';

  @override
  String get failedToCreateProfile => 'Profil konnte nicht erstellt werden';

  @override
  String get failedToDeleteProfile => 'Profil konnte nicht gelöscht werden';

  @override
  String get foodLogged => 'Essen erfolgreich gespeichert';

  @override
  String get historyAndProgress => 'Verlauf und Fortschritt';

  @override
  String get height => 'Größe';

  @override
  String get currentWeight => 'Aktuelles Gewicht';

  @override
  String get checkingConnection => 'Verbindung wird geprüft...';

  @override
  String get noInternetConnection => 'Keine Internetverbindung';

  @override
  String get pleaseConnectToInternet =>
      'Bitte verbinden Sie sich mit dem Internet, um fortzufahren';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get trackNutrition => 'Ernährung verfolgen';

  @override
  String get trackNutritionDesc =>
      'Mahlzeiten einfach protokollieren und Kalorien mit regionalen Lebensmitteln überwachen';

  @override
  String get trackProgress => 'Fortschritt verfolgen';

  @override
  String get trackProgressDesc =>
      'Diagramme und Verlauf Ihrer täglichen Kalorienaufnahme und Ziele anzeigen';

  @override
  String get personalizedProfile => 'Personalisiertes Profil';

  @override
  String get personalizedProfileDesc =>
      'Erstellen Sie mehrere Profile für Familienmitglieder mit individuellen Empfehlungen';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get profileSwitchedTitle => 'Profil gewechselt';

  @override
  String get profileSwitchedDesc =>
      'Die App muss neu gestartet werden, um das neue Profil vollständig anzuwenden. Jetzt neu starten?';

  @override
  String get later => 'Später';

  @override
  String get restartNow => 'Jetzt neu starten';
}
