// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'VitaCalo';

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
  String get remaining => 'Restant';

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
      'Vous utilisez le mode manuel. Certaines fonctionnalités comme l\'objectif calorique sont désactivées.';

  @override
  String get logFoodButton => 'Enregistrer un aliment';

  @override
  String get switchToPersonalized => 'Passer au mode personnalisé';

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
  String get startFresh => 'Nouveau départ';

  @override
  String get personalizeJourney => 'Personnalisez votre parcours';

  @override
  String get takeSurvey => 'Faire le questionnaire';

  @override
  String get continueManual => 'Continuer en mode manuel';

  @override
  String get foodAdded => 'Aliment ajouté !';

  @override
  String get entryDeleted => 'Entrée supprimée';

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
  String get positiveNumber => 'Doit être un nombre positif';

  @override
  String get positive => 'Doit être positif';

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
  String get restrictions => 'Restrictions / Allergies';

  @override
  String get clearProfileTitle => 'Effacer le profil ?';

  @override
  String get clearProfileDesc =>
      'Cela supprimera toutes vos données personnelles et réinitialisera le mode manuel.';

  @override
  String get clear => 'Effacer';

  @override
  String get profileCleared => 'Profil effacé avec succès';

  @override
  String ofTarget(Object kcal) {
    return 'sur $kcal kcal';
  }

  @override
  String get kcalDay => 'kcal/jour';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'sur $kcal kcal';
  }

  @override
  String get takeSurveyDesc =>
      'Veuillez compléter le questionnaire pour des informations personnalisées.';

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
  String get activityLevel => 'Niveau d\'activité';

  @override
  String get restrictionsLabel => 'Restrictions / Allergies';

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
  String get profileSaved => 'Profil mis à jour';

  @override
  String get basicInfo => 'Informations de base';

  @override
  String get goalsAndLifestyle => 'Objectifs et mode de vie';

  @override
  String get preferences => 'Préférences';

  @override
  String get location => 'Localisation';

  @override
  String get next => 'Suivant';

  @override
  String get settings => 'Paramètres';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get on => 'Activé';

  @override
  String get off => 'Désactivé';

  @override
  String get language => 'Langue';

  @override
  String get currentLanguage => 'Langue actuelle';

  @override
  String get reminders => 'Rappels';

  @override
  String get dailyReminderDesc => 'Recevez des rappels quotidiens de calories';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get backupYourData => 'Sauvegarder vos journaux et votre progression';

  @override
  String get importData => 'Importer les données';

  @override
  String get restoreYourData => 'Restaurer les données depuis la sauvegarde';

  @override
  String get aboutApp => 'À propos de l\'app';

  @override
  String get aboutDesc =>
      'Suivi de calories hors ligne avec aliments locaux et focus sur la confidentialité';

  @override
  String get manageProfiles => 'Gérer les profils';

  @override
  String get switchProfile => 'Changer de profil';

  @override
  String get noProfilesYet => 'Aucun profil pour le moment';

  @override
  String get createNewProfile => 'Créer un nouveau profil';

  @override
  String get profileName => 'Nom du profil';

  @override
  String get profileNameHint => 'ex. Membre de la famille 1';

  @override
  String get create => 'Créer';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get switchedTo => 'Changé pour';

  @override
  String get createdProfile => 'Profil créé';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProfile => 'Supprimer le profil';

  @override
  String get deleteProfileDesc =>
      'Cela supprimera définitivement toutes les données de ce profil. Cette action est irréversible.';

  @override
  String get profileDeleted => 'Profil supprimé';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get selectWeightUnit => 'Sélectionner l\'unité de poids';

  @override
  String get selectHeightUnit => 'Sélectionner l\'unité de taille';

  @override
  String get weightUnit => 'Unité de poids';

  @override
  String get heightUnit => 'Unité de taille';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get rateUs => 'Évaluez-nous';

  @override
  String get rateUsComingSoon =>
      'La fonctionnalité d\'évaluation arrive bientôt!';

  @override
  String get joinBeta => 'Rejoindre les tests bêta';

  @override
  String get betaComingSoon => 'Le programme de test bêta arrive bientôt!';

  @override
  String get todayCalories => 'Calories du jour';

  @override
  String get manualEntry => 'Saisie manuelle';

  @override
  String get failedToCreateProfile => 'Échec de la création du profil';

  @override
  String get failedToDeleteProfile => 'Échec de la suppression du profil';

  @override
  String get foodLogged => 'Aliment enregistré avec succès';

  @override
  String get historyAndProgress => 'Historique et progression';

  @override
  String get height => 'Taille';

  @override
  String get currentWeight => 'Poids actuel';

  @override
  String get checkingConnection => 'Vérification de la connexion...';

  @override
  String get noInternetConnection => 'Pas de connexion internet';

  @override
  String get pleaseConnectToInternet =>
      'Veuillez vous connecter à Internet pour continuer';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get trackNutrition => 'Suivez votre nutrition';

  @override
  String get trackNutritionDesc =>
      'Enregistrez facilement vos repas et surveillez vos calories avec des aliments locaux';

  @override
  String get trackProgress => 'Suivez vos progrès';

  @override
  String get trackProgressDesc =>
      'Consultez les graphiques et l\'historique de vos calories quotidiennes et de vos objectifs';

  @override
  String get personalizedProfile => 'Profil personnalisé';

  @override
  String get personalizedProfileDesc =>
      'Créez plusieurs profils pour les membres de la famille avec des recommandations personnalisées';

  @override
  String get getStarted => 'Commencer';

  @override
  String get profileSwitchedTitle => 'Profil changé';

  @override
  String get profileSwitchedDesc =>
      'L\'application doit redémarrer pour appliquer complètement le nouveau profil. Redémarrer maintenant ?';

  @override
  String get later => 'Plus tard';

  @override
  String get restartNow => 'Redémarrer maintenant';
}
