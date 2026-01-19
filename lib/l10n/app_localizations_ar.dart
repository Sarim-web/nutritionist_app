// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'اختصاصي التغذية';

  @override
  String get logFood => 'تسجيل الطعام';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get yourProfile => 'ملفك الشخصي';

  @override
  String get commonFoods => 'الأطعمة الشائعة';

  @override
  String get searchFoods => 'ابحث عن الأطعمة...';

  @override
  String today(Object kcal) {
    return 'اليوم: $kcal سعرة حرارية';
  }

  @override
  String remaining(Object kcal) {
    return 'المتبقي: $kcal سعرة حرارية';
  }

  @override
  String get newDayMessage => 'بدأ يوم جديد — تمت إعادة تعيين السعرات إلى 0';

  @override
  String get loggedToday => 'تم تسجيله اليوم';

  @override
  String get noFoodToday => 'لم يتم تسجيل أي طعام اليوم بعد';

  @override
  String get addFood => 'إضافة طعام';

  @override
  String get foodName => 'اسم الطعام';

  @override
  String get caloriesPerServing => 'السعرات الحرارية (لكل حصة)';

  @override
  String get quantity => 'الكمية';

  @override
  String get mealCategory => 'فئة الوجبة';

  @override
  String get done => 'تم';

  @override
  String get manualModeActive => 'الوضع اليدوي مفعل';

  @override
  String get manualModeDesc =>
      'أنت تتتبع السعرات الحرارية بدون هدف مخصص.\nقم بتسجيل الطعام بحرية — يمكنك إجراء الاستبيان في أي وقت للحصول على أهداف مخصصة.';

  @override
  String get logFoodButton => 'تسجيل الطعام';

  @override
  String get switchToPersonalized =>
      'التحويل إلى الوضع المخصص (إجراء الاستبيان)';

  @override
  String get dailyProgress => 'التقدم اليومي';

  @override
  String get goodPace => 'وتيرة جيدة — استمر!';

  @override
  String get almostThere => 'قريب جدًا — كن حذرًا';

  @override
  String get overTarget => 'تجاوزت الهدف — فكر في خيارات أخف';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get startFresh => 'البدء من جديد (مسح الملف الشخصي)';

  @override
  String get personalizeJourney => 'خصص رحلتك';

  @override
  String get takeSurvey => 'إجراء استبيان الملف الشخصي';

  @override
  String get continueManual => 'المتابعة في الوضع اليدوي';

  @override
  String get foodAdded => 'تمت إضافة الطعام!';

  @override
  String get all => 'الكل';

  @override
  String get breakfast => 'الإفطار';

  @override
  String get lunch => 'الغداء';

  @override
  String get dinner => 'العشاء';

  @override
  String get snack => 'وجبة خفيفة';

  @override
  String get fruit => 'فواكه';

  @override
  String get dessert => 'تحلية';

  @override
  String get drink => 'مشروب';

  @override
  String get allRegions => 'جميع المناطق';

  @override
  String get pakistan => 'باكستان';

  @override
  String get india => 'الهند';

  @override
  String get saudiArabia => 'المملكة العربية السعودية';

  @override
  String get uae => 'الإمارات العربية المتحدة';

  @override
  String get usa => 'الولايات المتحدة';

  @override
  String get uk => 'المملكة المتحدة';

  @override
  String get germany => 'ألمانيا';

  @override
  String get france => 'فرنسا';

  @override
  String get spain => 'إسبانيا';

  @override
  String get indonesia => 'إندونيسيا';

  @override
  String get turkey => 'تركيا';

  @override
  String get required => 'مطلوب';

  @override
  String get positiveNumber => 'رقم موجب';

  @override
  String get positive => 'موجب';

  @override
  String get entryDeleted => 'تم حذف الإدخال';

  @override
  String get unknown => 'غير معروف';

  @override
  String get kcal => 'سعرة حرارية';

  @override
  String get caloriesHelper => 'التقدير مقبول — استخدم الاقتراحات أعلاه';

  @override
  String get target => 'الهدف';

  @override
  String get goal => 'الغاية';

  @override
  String get activity => 'النشاط';

  @override
  String get targetWeight => 'الوزن المستهدف';

  @override
  String get dietaryPreference => 'التفضيل الغذائي';

  @override
  String get restrictions => 'القيود';

  @override
  String get clearProfileTitle => 'مسح الملف الشخصي؟';

  @override
  String get clearProfileDesc =>
      'سيؤدي هذا إلى إزالة جميع معلومات الملف الشخصي المحفوظة وسجلات السعرات الحرارية. يمكنك إجراء الاستبيان مرة أخرى للبدء من جديد.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'مسح';

  @override
  String get profileCleared => 'تم مسح الملف الشخصي والسجلات';

  @override
  String ofTarget(Object kcal) {
    return 'من أصل $kcal سعرة حرارية';
  }

  @override
  String get kcalDay => 'سعرة حرارية/اليوم';

  @override
  String get takeSurveyDesc =>
      'أكمل الاستبيان السريع للحصول على هدف سعرات مخصص وتوصيات أفضل.';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'من أصل $kcal سعرة حرارية';
  }

  @override
  String get age => 'العمر';

  @override
  String get gender => 'الجنس';

  @override
  String get heightCm => 'الطول (سم)';

  @override
  String get currentWeightKg => 'الوزن الحالي (كغ)';

  @override
  String get targetWeightKgOptional => 'الوزن المستهدف (كغ) — اختياري';

  @override
  String get targetWeightHelper => 'اتركه فارغًا إذا لم تكن متأكدًا بعد';

  @override
  String get mainGoal => 'الهدف الرئيسي';

  @override
  String get activityLevel => 'مستوى النشاط';

  @override
  String get restrictionsLabel => 'هل لديك حساسية، عدم تحمل أو حالات طبية؟';

  @override
  String get restrictionsHelper =>
      'مثل عدم تحمل اللاكتوز، السكري، حساسية المكسرات… (اختياري)';

  @override
  String get guidanceQuestion => 'ما مقدار الإرشاد الذي تريده؟';

  @override
  String get guidanceLow => 'أعرف الأساسيات';

  @override
  String get guidanceMedium => 'في المنتصف';

  @override
  String get guidanceHigh => 'أرشدني بدقة';

  @override
  String get regionCountry => 'المنطقة / الدولة';

  @override
  String get regionHelper =>
      'يساعد في عرض الأطعمة المحلية والاقتراحات المناسبة';

  @override
  String get saveContinue => 'حفظ والمتابعة';

  @override
  String get skipManual => 'تخطي → الوضع اليدوي';

  @override
  String get updateProfileTitle => 'تحديث الملف الشخصي؟';

  @override
  String get updateProfileDesc =>
      'لديك ملف شخصي محفوظ بالفعل. سيؤدي التحديث إلى استبدال المعلومات القديمة. هل تريد المتابعة؟';

  @override
  String get update => 'تحديث';

  @override
  String get profileSaved => 'تم حفظ الملف الشخصي بنجاح';

  @override
  String get basicInfo => 'المعلومات الأساسية';

  @override
  String get goalsAndLifestyle => 'الأهداف ونمط الحياة';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get location => 'الموقع';

  @override
  String get next => 'التالي';
}
