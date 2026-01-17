// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Nutritionniste';

  @override
  String get logFood => 'Enregistrer un aliment';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get yourProfile => 'Votre profil';

  @override
  String get commonFoods => 'Aliments courants';

  @override
  String get searchFoods => 'Rechercher des aliments...';

  @override
  String today(Object kcal) {
    return 'Aujourd’hui : $kcal kcal';
  }

  @override
  String remaining(Object kcal) {
    return 'Restant : $kcal kcal';
  }

  @override
  String get newDayMessage =>
      'Nouveau jour commencé — calories réinitialisées à 0';

  @override
  String get loggedToday => 'Enregistré aujourd’hui';

  @override
  String get noFoodToday => 'Aucun aliment enregistré aujourd’hui';

  @override
  String get addFood => 'Ajouter un aliment';

  @override
  String get foodName => 'Nom de l’aliment';

  @override
  String get caloriesPerServing => 'Calories (par portion)';

  @override
  String get quantity => 'Quantité';

  @override
  String get mealCategory => 'Catégorie de repas';

  @override
  String get done => 'Terminé';

  @override
  String get manualModeActive => 'Mode manuel actif';

  @override
  String get manualModeDesc =>
      'Vous suivez les calories sans objectif personnalisé.\nEnregistrez librement les aliments — vous pouvez remplir le questionnaire à tout moment pour obtenir des objectifs personnalisés.';

  @override
  String get logFoodButton => 'Enregistrer un aliment';

  @override
  String get switchToPersonalized =>
      'Passer en mode personnalisé (Faire le questionnaire)';

  @override
  String get dailyProgress => 'Progression quotidienne';

  @override
  String get goodPace => 'Bon rythme — continuez !';

  @override
  String get almostThere => 'Presque atteint — restez vigilant';

  @override
  String get overTarget =>
      'Au-dessus de l’objectif — envisagez des choix plus légers';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get startFresh => 'Recommencer (Effacer le profil)';

  @override
  String get personalizeJourney => 'Personnalisez votre parcours';

  @override
  String get takeSurvey => 'Faire le questionnaire de profil';

  @override
  String get continueManual => 'Continuer en mode manuel';

  @override
  String get foodAdded => 'Aliment ajouté !';

  @override
  String get all => 'Tous';

  @override
  String get breakfast => 'Petit-déjeuner';

  @override
  String get lunch => 'Déjeuner';

  @override
  String get dinner => 'Dîner';

  @override
  String get snack => 'Collation';

  @override
  String get fruit => 'Fruit';

  @override
  String get dessert => 'Dessert';

  @override
  String get drink => 'Boisson';

  @override
  String get allRegions => 'Toutes les régions';

  @override
  String get pakistan => 'Pakistan';

  @override
  String get india => 'Inde';

  @override
  String get saudiArabia => 'Arabie saoudite';

  @override
  String get uae => 'Émirats arabes unis';

  @override
  String get usa => 'États-Unis';

  @override
  String get uk => 'Royaume-Uni';

  @override
  String get germany => 'Allemagne';

  @override
  String get france => 'France';

  @override
  String get spain => 'Espagne';

  @override
  String get indonesia => 'Indonésie';

  @override
  String get turkey => 'Turquie';

  @override
  String get required => 'Obligatoire';

  @override
  String get positiveNumber => 'Nombre positif';

  @override
  String get positive => 'Positif';

  @override
  String get entryDeleted => 'Entrée supprimée';

  @override
  String get unknown => 'Inconnu';

  @override
  String get kcal => 'kcal';

  @override
  String get caloriesHelper =>
      'Une estimation suffit — utilisez les options ci-dessus';

  @override
  String get target => 'Objectif';

  @override
  String get goal => 'But';

  @override
  String get activity => 'Activité';

  @override
  String get targetWeight => 'Poids cible';

  @override
  String get dietaryPreference => 'Préférence alimentaire';

  @override
  String get restrictions => 'Restrictions';

  @override
  String get clearProfileTitle => 'Effacer le profil ?';

  @override
  String get clearProfileDesc =>
      'Cela supprimera toutes les informations de profil et les journaux de calories enregistrés. Vous pourrez refaire le questionnaire pour repartir à zéro.';

  @override
  String get cancel => 'Annuler';

  @override
  String get clear => 'Effacer';

  @override
  String get profileCleared => 'Profil et journaux effacés';

  @override
  String ofTarget(Object kcal) {
    return 'sur $kcal kcal';
  }

  @override
  String get kcalDay => 'kcal/jour';

  @override
  String get takeSurveyDesc =>
      'Complétez le profil rapide pour obtenir un objectif calorique personnalisé et de meilleures recommandations.';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'sur $kcal kcal';
  }

  @override
  String get age => 'Âge';

  @override
  String get gender => 'Genre';

  @override
  String get heightCm => 'Taille (cm)';

  @override
  String get currentWeightKg => 'Poids actuel (kg)';

  @override
  String get targetWeightKgOptional => 'Poids cible (kg) — facultatif';

  @override
  String get targetWeightHelper => 'Laissez vide si vous n’êtes pas encore sûr';

  @override
  String get mainGoal => 'Objectif principal';

  @override
  String get activityLevel => 'Niveau d’activité';

  @override
  String get restrictionsLabel =>
      'Allergies, intolérances ou conditions médicales ?';

  @override
  String get restrictionsHelper =>
      'Ex. intolérance au lactose, diabète, allergie aux noix… (facultatif)';

  @override
  String get guidanceQuestion =>
      'Quel niveau d’accompagnement souhaitez-vous ?';

  @override
  String get guidanceLow => 'Je connais les bases';

  @override
  String get guidanceMedium => 'Quelque part entre les deux';

  @override
  String get guidanceHigh => 'Guide-moi strictement';

  @override
  String get regionCountry => 'Région / Pays';

  @override
  String get regionHelper =>
      'Aide à afficher des aliments et suggestions locales pertinentes';

  @override
  String get saveContinue => 'Enregistrer et continuer';

  @override
  String get skipManual => 'Ignorer → Mode manuel';

  @override
  String get updateProfileTitle => 'Mettre à jour le profil ?';

  @override
  String get updateProfileDesc =>
      'Vous avez déjà un profil enregistré. La mise à jour remplacera les anciennes informations. Continuer ?';

  @override
  String get update => 'Mettre à jour';

  @override
  String get profileSaved => 'Profil enregistré avec succès';
}
