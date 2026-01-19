// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Nutricionista';

  @override
  String get logFood => 'Registrar comida';

  @override
  String get dashboard => 'Panel';

  @override
  String get yourProfile => 'Tu perfil';

  @override
  String get commonFoods => 'Comidas comunes';

  @override
  String get searchFoods => 'Buscar alimentos...';

  @override
  String today(Object kcal) {
    return 'Hoy: $kcal kcal';
  }

  @override
  String remaining(Object kcal) {
    return 'Restante: $kcal kcal';
  }

  @override
  String get newDayMessage => 'Nuevo día iniciado — calorías reiniciadas a 0';

  @override
  String get loggedToday => 'Registrado hoy';

  @override
  String get noFoodToday => 'Aún no se ha registrado comida hoy';

  @override
  String get addFood => 'Agregar comida';

  @override
  String get foodName => 'Nombre del alimento';

  @override
  String get caloriesPerServing => 'Calorías (por porción)';

  @override
  String get quantity => 'Cantidad';

  @override
  String get mealCategory => 'Categoría de comida';

  @override
  String get done => 'Hecho';

  @override
  String get manualModeActive => 'Modo manual activo';

  @override
  String get manualModeDesc =>
      'Estás registrando calorías sin un objetivo personalizado.\nRegistra alimentos libremente — puedes realizar la encuesta en cualquier momento para obtener objetivos personalizados.';

  @override
  String get logFoodButton => 'Registrar comida';

  @override
  String get switchToPersonalized =>
      'Cambiar a modo personalizado (Realizar encuesta)';

  @override
  String get dailyProgress => 'Progreso diario';

  @override
  String get goodPace => 'Buen ritmo — ¡sigue así!';

  @override
  String get almostThere => 'Casi allí — mantente atento';

  @override
  String get overTarget =>
      'Por encima del objetivo — considera opciones más ligeras';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get startFresh => 'Comenzar de nuevo (Borrar perfil)';

  @override
  String get personalizeJourney => 'Personaliza tu viaje';

  @override
  String get takeSurvey => 'Realizar encuesta de perfil';

  @override
  String get continueManual => 'Continuar en modo manual';

  @override
  String get foodAdded => '¡Comida agregada!';

  @override
  String get all => 'Todo';

  @override
  String get breakfast => 'Desayuno';

  @override
  String get lunch => 'Almuerzo';

  @override
  String get dinner => 'Cena';

  @override
  String get snack => 'Bocadillo';

  @override
  String get fruit => 'Fruta';

  @override
  String get dessert => 'Postre';

  @override
  String get drink => 'Bebida';

  @override
  String get allRegions => 'Todas las regiones';

  @override
  String get pakistan => 'Pakistán';

  @override
  String get india => 'India';

  @override
  String get saudiArabia => 'Arabia Saudita';

  @override
  String get uae => 'Emiratos Árabes Unidos';

  @override
  String get usa => 'Estados Unidos';

  @override
  String get uk => 'Reino Unido';

  @override
  String get germany => 'Alemania';

  @override
  String get france => 'Francia';

  @override
  String get spain => 'España';

  @override
  String get indonesia => 'Indonesia';

  @override
  String get turkey => 'Turquía';

  @override
  String get required => 'Requerido';

  @override
  String get positiveNumber => 'Número positivo';

  @override
  String get positive => 'Positivo';

  @override
  String get entryDeleted => 'Entrada eliminada';

  @override
  String get unknown => 'Desconocido';

  @override
  String get kcal => 'kcal';

  @override
  String get caloriesHelper =>
      'La estimación es suficiente — usa las opciones de arriba';

  @override
  String get target => 'Objetivo';

  @override
  String get goal => 'Meta';

  @override
  String get activity => 'Actividad';

  @override
  String get targetWeight => 'Peso objetivo';

  @override
  String get dietaryPreference => 'Preferencia alimentaria';

  @override
  String get restrictions => 'Restricciones';

  @override
  String get clearProfileTitle => '¿Borrar perfil?';

  @override
  String get clearProfileDesc =>
      'Esto eliminará toda la información del perfil y los registros de calorías guardados. Puedes realizar la encuesta nuevamente para comenzar de nuevo.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clear => 'Borrar';

  @override
  String get profileCleared => 'Perfil y registros borrados';

  @override
  String ofTarget(Object kcal) {
    return 'de $kcal kcal';
  }

  @override
  String get kcalDay => 'kcal/día';

  @override
  String get takeSurveyDesc =>
      'Completa el perfil rápido para obtener un objetivo de calorías personalizado y mejores recomendaciones.';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'de $kcal kcal';
  }

  @override
  String get age => 'Edad';

  @override
  String get gender => 'Género';

  @override
  String get heightCm => 'Altura (cm)';

  @override
  String get currentWeightKg => 'Peso actual (kg)';

  @override
  String get targetWeightKgOptional => 'Peso objetivo (kg) — opcional';

  @override
  String get targetWeightHelper => 'Déjalo vacío si aún no estás seguro';

  @override
  String get mainGoal => 'Objetivo principal';

  @override
  String get activityLevel => 'Nivel de actividad';

  @override
  String get restrictionsLabel =>
      '¿Alergias, intolerancias o condiciones médicas?';

  @override
  String get restrictionsHelper =>
      'Ej. intolerancia a la lactosa, diabetes, alergia a frutos secos… (opcional)';

  @override
  String get guidanceQuestion => '¿Cuánta orientación deseas?';

  @override
  String get guidanceLow => 'Conozco lo básico';

  @override
  String get guidanceMedium => 'Algo intermedio';

  @override
  String get guidanceHigh => 'Guíame estrictamente';

  @override
  String get regionCountry => 'Región / País';

  @override
  String get regionHelper =>
      'Ayuda a mostrar alimentos y sugerencias locales relevantes';

  @override
  String get saveContinue => 'Guardar y continuar';

  @override
  String get skipManual => 'Omitir → Modo manual';

  @override
  String get updateProfileTitle => '¿Actualizar perfil?';

  @override
  String get updateProfileDesc =>
      'Ya tienes un perfil guardado. Actualizarlo reemplazará la información anterior. ¿Continuar?';

  @override
  String get update => 'Actualizar';

  @override
  String get profileSaved => 'Perfil guardado correctamente';

  @override
  String get basicInfo => 'Información básica';

  @override
  String get goalsAndLifestyle => 'Objetivos y estilo de vida';

  @override
  String get preferences => 'Preferencias';

  @override
  String get location => 'Ubicación';

  @override
  String get next => 'Siguiente';
}
