// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'VitaCalo';

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
  String get remaining => 'المتبقي';

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
      'أنت تستخدم الوضع اليدوي. بعض الميزات مثل هدف السعرات معطلة.';

  @override
  String get logFoodButton => 'تسجيل الطعام';

  @override
  String get switchToPersonalized => 'التبديل إلى الوضع المخصص';

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
  String get startFresh => 'بداية جديدة';

  @override
  String get personalizeJourney => 'خصص رحلتك';

  @override
  String get takeSurvey => 'إجراء الاستبيان';

  @override
  String get continueManual => 'الاستمرار في الوضع اليدوي';

  @override
  String get foodAdded => 'تمت إضافة الطعام!';

  @override
  String get entryDeleted => 'تم حذف الإدخال';

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
  String get positiveNumber => 'يجب أن يكون رقمًا موجبًا';

  @override
  String get positive => 'يجب أن يكون موجبًا';

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
  String get restrictions => 'القيود / الحساسية';

  @override
  String get clearProfileTitle => 'مسح الملف الشخصي؟';

  @override
  String get clearProfileDesc =>
      'سيؤدي هذا إلى حذف جميع البيانات الشخصية وإعادة التعيين إلى الوضع اليدوي.';

  @override
  String get clear => 'مسح';

  @override
  String get profileCleared => 'تم مسح الملف الشخصي بنجاح';

  @override
  String ofTarget(Object kcal) {
    return 'من أصل $kcal سعرة حرارية';
  }

  @override
  String get kcalDay => 'سعرة حرارية/اليوم';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'من أصل $kcal سعرة حرارية';
  }

  @override
  String get takeSurveyDesc => 'يرجى إكمال الاستبيان للحصول على نتائج مخصصة.';

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
  String get restrictionsLabel => 'القيود / الحساسية';

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
  String get profileSaved => 'تم تحديث الملف الشخصي';

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

  @override
  String get settings => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get on => 'تشغيل';

  @override
  String get off => 'إيقاف';

  @override
  String get language => 'اللغة';

  @override
  String get currentLanguage => 'اللغة الحالية';

  @override
  String get reminders => 'التذكيرات';

  @override
  String get dailyReminderDesc => 'احصل على تذكيرات يومية بالسعرات';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get backupYourData => 'نسخ احتياطي لبياناتك وسجلاتك';

  @override
  String get importData => 'استيراد البيانات';

  @override
  String get restoreYourData => 'استعادة البيانات من النسخ الاحتياطي';

  @override
  String get aboutApp => 'عن التطبيق';

  @override
  String get aboutDesc =>
      'متعقب سعرات حرارية غير متصل بالإنترنت مع أطعمة محلية وتركيز على الخصوصية';

  @override
  String get manageProfiles => 'إدارة الملفات الشخصية';

  @override
  String get switchProfile => 'تبديل الملف الشخصي';

  @override
  String get noProfilesYet => 'لا توجد ملفات شخصية بعد';

  @override
  String get createNewProfile => 'إنشاء ملف شخصي جديد';

  @override
  String get profileName => 'اسم الملف الشخصي';

  @override
  String get profileNameHint => 'مثال: فرد العائلة 1';

  @override
  String get create => 'إنشاء';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get switchedTo => 'تم التبديل إلى';

  @override
  String get createdProfile => 'تم إنشاء الملف الشخصي';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProfile => 'حذف الملف الشخصي';

  @override
  String get deleteProfileDesc =>
      'سيؤدي هذا إلى حذف جميع بيانات هذا الملف الشخصي نهائيًا. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get profileDeleted => 'تم حذف الملف الشخصي';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get selectWeightUnit => 'اختر وحدة الوزن';

  @override
  String get selectHeightUnit => 'اختر وحدة الطول';

  @override
  String get weightUnit => 'وحدة الوزن';

  @override
  String get heightUnit => 'وحدة الطول';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get rateUs => 'قيمنا';

  @override
  String get rateUsComingSoon => 'ستتوفر ميزة تقييمنا قريباً!';

  @override
  String get joinBeta => 'انضم إلى اختبار بيتا';

  @override
  String get betaComingSoon => 'سيتم إطلاق برنامج اختبار بيتا قريباً!';

  @override
  String get todayCalories => 'سعرات اليوم';

  @override
  String get manualEntry => 'إدخال يدوي';

  @override
  String get failedToCreateProfile => 'فشل في إنشاء الملف الشخصي';

  @override
  String get failedToDeleteProfile => 'فشل في حذف الملف الشخصي';

  @override
  String get foodLogged => 'تم تسجيل الطعام بنجاح';

  @override
  String get historyAndProgress => 'السجل والتقدم';

  @override
  String get height => 'الطول';

  @override
  String get currentWeight => 'الوزن الحالي';

  @override
  String get checkingConnection => 'جارٍ التحقق من الاتصال...';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get pleaseConnectToInternet => 'يرجى الاتصال بالإنترنت للمتابعة';

  @override
  String get tryAgain => 'إعادة المحاولة';

  @override
  String get trackNutrition => 'تتبع تغذيتك';

  @override
  String get trackNutritionDesc =>
      'سجل وجباتك بسهولة وراقب السعرات الحرارية مع الأطعمة المحلية';

  @override
  String get trackProgress => 'تتبع تقدمك';

  @override
  String get trackProgressDesc =>
      'عرض الرسوم البيانية وسجل السعرات الحرارية اليومية والأهداف';

  @override
  String get personalizedProfile => 'ملف شخصي مخصص';

  @override
  String get personalizedProfileDesc =>
      'أنشئ ملفات تعريف متعددة لأفراد الأسرة مع توصيات مخصصة';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get profileSwitchedTitle => 'تم تبديل الملف الشخصي';

  @override
  String get profileSwitchedDesc =>
      'يجب إعادة تشغيل التطبيق لتطبيق الملف الشخصي الجديد بالكامل. هل تريد إعادة التشغيل الآن؟';

  @override
  String get later => 'لاحقًا';

  @override
  String get restartNow => 'إعادة التشغيل الآن';
}
