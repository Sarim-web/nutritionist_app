// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Beslenme Uzmanı';

  @override
  String get logFood => 'Yiyecek Kaydet';

  @override
  String get dashboard => 'Kontrol Paneli';

  @override
  String get yourProfile => 'Profiliniz';

  @override
  String get commonFoods => 'Yaygın Yiyecekler';

  @override
  String get searchFoods => 'Yiyecek ara...';

  @override
  String today(Object kcal) {
    return 'Bugün: $kcal kcal';
  }

  @override
  String remaining(Object kcal) {
    return 'Kalan: $kcal kcal';
  }

  @override
  String get newDayMessage => 'Yeni gün başladı — kaloriler 0’a sıfırlandı';

  @override
  String get loggedToday => 'Bugün kaydedilenler';

  @override
  String get noFoodToday => 'Bugün henüz yiyecek kaydedilmedi';

  @override
  String get addFood => 'Yiyecek ekle';

  @override
  String get foodName => 'Yiyecek adı';

  @override
  String get caloriesPerServing => 'Kalori (porsiyon başına)';

  @override
  String get quantity => 'Miktar';

  @override
  String get mealCategory => 'Öğün kategorisi';

  @override
  String get done => 'Bitti';

  @override
  String get manualModeActive => 'Manuel Mod Aktif';

  @override
  String get manualModeDesc =>
      'Kişiselleştirilmiş bir hedef olmadan kalori takip ediyorsunuz.\nYiyecekleri özgürce kaydedin — istediğiniz zaman anketi doldurarak özel hedefler alabilirsiniz.';

  @override
  String get logFoodButton => 'Yiyecek Kaydet';

  @override
  String get switchToPersonalized =>
      'Kişiselleştirilmiş Moda Geç (Anketi Doldur)';

  @override
  String get dailyProgress => 'Günlük İlerleme';

  @override
  String get goodPace => 'İyi gidiyorsunuz — devam edin!';

  @override
  String get almostThere => 'Neredeyse ulaşıldı — dikkatli olun';

  @override
  String get overTarget => 'Hedefin üzerinde — daha hafif seçimler yapın';

  @override
  String get editProfile => 'Profili Düzenle';

  @override
  String get startFresh => 'Baştan Başla (Profili Temizle)';

  @override
  String get personalizeJourney => 'Yolculuğunuzu kişiselleştirin';

  @override
  String get takeSurvey => 'Profil Anketini Doldur';

  @override
  String get continueManual => 'Manuel Modda Devam Et';

  @override
  String get foodAdded => 'Yiyecek eklendi!';

  @override
  String get all => 'Tümü';

  @override
  String get breakfast => 'Kahvaltı';

  @override
  String get lunch => 'Öğle Yemeği';

  @override
  String get dinner => 'Akşam Yemeği';

  @override
  String get snack => 'Atıştırmalık';

  @override
  String get fruit => 'Meyve';

  @override
  String get dessert => 'Tatlı';

  @override
  String get drink => 'İçecek';

  @override
  String get allRegions => 'Tüm Bölgeler';

  @override
  String get pakistan => 'Pakistan';

  @override
  String get india => 'Hindistan';

  @override
  String get saudiArabia => 'Suudi Arabistan';

  @override
  String get uae => 'Birleşik Arap Emirlikleri';

  @override
  String get usa => 'ABD';

  @override
  String get uk => 'Birleşik Krallık';

  @override
  String get germany => 'Almanya';

  @override
  String get france => 'Fransa';

  @override
  String get spain => 'İspanya';

  @override
  String get indonesia => 'Endonezya';

  @override
  String get turkey => 'Türkiye';

  @override
  String get required => 'Zorunlu';

  @override
  String get positiveNumber => 'Pozitif sayı';

  @override
  String get positive => 'Pozitif';

  @override
  String get entryDeleted => 'Kayıt silindi';

  @override
  String get unknown => 'Bilinmiyor';

  @override
  String get kcal => 'kcal';

  @override
  String get caloriesHelper =>
      'Tahmin yeterlidir — yukarıdaki seçenekleri kullanın';

  @override
  String get target => 'Hedef';

  @override
  String get goal => 'Amaç';

  @override
  String get activity => 'Aktivite';

  @override
  String get targetWeight => 'Hedef kilo';

  @override
  String get dietaryPreference => 'Beslenme tercihi';

  @override
  String get restrictions => 'Kısıtlamalar';

  @override
  String get clearProfileTitle => 'Profil temizlensin mi?';

  @override
  String get clearProfileDesc =>
      'Bu işlem tüm kayıtlı profil bilgilerini ve kalori günlüklerini silecektir. Yeniden başlamak için anketi tekrar doldurabilirsiniz.';

  @override
  String get cancel => 'İptal';

  @override
  String get clear => 'Temizle';

  @override
  String get profileCleared => 'Profil ve kayıtlar temizlendi';

  @override
  String ofTarget(Object kcal) {
    return '$kcal kcal üzerinden';
  }

  @override
  String get kcalDay => 'kcal/gün';

  @override
  String get takeSurveyDesc =>
      'Özel bir kalori hedefi ve daha iyi öneriler almak için hızlı profili tamamlayın.';

  @override
  String dailyTargetLabel(Object kcal) {
    return '$kcal kcal üzerinden';
  }

  @override
  String get age => 'Yaş';

  @override
  String get gender => 'Cinsiyet';

  @override
  String get heightCm => 'Boy (cm)';

  @override
  String get currentWeightKg => 'Mevcut kilo (kg)';

  @override
  String get targetWeightKgOptional => 'Hedef kilo (kg) — isteğe bağlı';

  @override
  String get targetWeightHelper => 'Henüz emin değilseniz boş bırakın';

  @override
  String get mainGoal => 'Ana hedef';

  @override
  String get activityLevel => 'Aktivite seviyesi';

  @override
  String get restrictionsLabel =>
      'Alerjiler, intoleranslar veya tıbbi durumlar?';

  @override
  String get restrictionsHelper =>
      'Örn. laktoz intoleransı, diyabet, fındık alerjisi… (isteğe bağlı)';

  @override
  String get guidanceQuestion => 'Ne kadar rehberlik istiyorsunuz?';

  @override
  String get guidanceLow => 'Temel bilgileri biliyorum';

  @override
  String get guidanceMedium => 'İkisinin arasında';

  @override
  String get guidanceHigh => 'Beni sıkı şekilde yönlendir';

  @override
  String get regionCountry => 'Bölge / Ülke';

  @override
  String get regionHelper =>
      'Yerel ve ilgili yiyecekleri ve önerileri göstermeye yardımcı olur';

  @override
  String get saveContinue => 'Kaydet ve Devam Et';

  @override
  String get skipManual => 'Atla → Manuel Mod';

  @override
  String get updateProfileTitle => 'Profil güncellensin mi?';

  @override
  String get updateProfileDesc =>
      'Zaten kayıtlı bir profiliniz var. Güncelleme eski bilgilerin yerine geçecektir. Devam edilsin mi?';

  @override
  String get update => 'Güncelle';

  @override
  String get profileSaved => 'Profil başarıyla kaydedildi';
}
