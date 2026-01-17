// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Ernährungsberater';

  @override
  String get logFood => 'Essen protokollieren';

  @override
  String get dashboard => 'Übersicht';

  @override
  String get yourProfile => 'Ihr Profil';

  @override
  String get commonFoods => 'Häufige Lebensmittel';

  @override
  String get searchFoods => 'Lebensmittel suchen...';

  @override
  String today(Object kcal) {
    return 'Heute: $kcal kcal';
  }

  @override
  String remaining(Object kcal) {
    return 'Verbleibend: $kcal kcal';
  }

  @override
  String get newDayMessage =>
      'Neuer Tag gestartet — Kalorien auf 0 zurückgesetzt';

  @override
  String get loggedToday => 'Heute protokolliert';

  @override
  String get noFoodToday =>
      'Heute wurden noch keine Lebensmittel protokolliert';

  @override
  String get addFood => 'Lebensmittel hinzufügen';

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
      'Sie verfolgen Kalorien ohne ein personalisiertes Ziel.\nProtokollieren Sie Lebensmittel frei — Sie können jederzeit die Umfrage ausfüllen, um individuelle Ziele zu erhalten.';

  @override
  String get logFoodButton => 'Essen protokollieren';

  @override
  String get switchToPersonalized =>
      'Zum personalisierten Modus wechseln (Umfrage ausfüllen)';

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
  String get startFresh => 'Neu beginnen (Profil löschen)';

  @override
  String get personalizeJourney => 'Gestalten Sie Ihre Reise individuell';

  @override
  String get takeSurvey => 'Profilumfrage ausfüllen';

  @override
  String get continueManual => 'Im manuellen Modus fortfahren';

  @override
  String get foodAdded => 'Lebensmittel hinzugefügt!';

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
  String get positiveNumber => 'Positive Zahl';

  @override
  String get positive => 'Positiv';

  @override
  String get entryDeleted => 'Eintrag gelöscht';

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
  String get restrictions => 'Einschränkungen';

  @override
  String get clearProfileTitle => 'Profil löschen?';

  @override
  String get clearProfileDesc =>
      'Dadurch werden alle gespeicherten Profilinformationen und Kalorienprotokolle entfernt. Sie können die Umfrage erneut ausfüllen, um neu zu starten.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get clear => 'Löschen';

  @override
  String get profileCleared => 'Profil und Protokolle gelöscht';

  @override
  String ofTarget(Object kcal) {
    return 'von $kcal kcal';
  }

  @override
  String get kcalDay => 'kcal/Tag';

  @override
  String get takeSurveyDesc =>
      'Füllen Sie das kurze Profil aus, um ein individuelles Kalorienziel und bessere Empfehlungen zu erhalten.';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'von $kcal kcal';
  }

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
  String get activityLevel => 'Aktivitätsniveau';

  @override
  String get restrictionsLabel =>
      'Allergien, Unverträglichkeiten oder medizinische Bedingungen?';

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
  String get profileSaved => 'Profil erfolgreich gespeichert';
}
