// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'VitaCalo';

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
  String get remaining => 'Kalan';

  @override
  String get newDayMessage => 'Yeni gün başladı — kaloriler 0’a sıfırlandı';

  @override
  String get loggedToday => 'Bugün kaydedilenler';

  @override
  String get noFoodToday => 'Bugün henüz yiyecek kaydedilmedi';

  @override
  String get addFood => 'Yiyecek Ekle';

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
      'Manuel modu kullanıyorsunuz. Kalori hedefi gibi bazı özellikler devre dışı.';

  @override
  String get logFoodButton => 'Yiyecek Kaydet';

  @override
  String get switchToPersonalized => 'Kişiselleştirilmiş moda geç';

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
  String get startFresh => 'Yeni başlangıç';

  @override
  String get personalizeJourney => 'Yolculuğunuzu kişiselleştirin';

  @override
  String get takeSurvey => 'Anketi doldur';

  @override
  String get continueManual => 'Manuel modda devam et';

  @override
  String get foodAdded => 'Yiyecek eklendi!';

  @override
  String get entryDeleted => 'Giriş silindi';

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
  String get required => 'Gerekli';

  @override
  String get positiveNumber => 'Pozitif bir sayı olmalı';

  @override
  String get positive => 'Pozitif olmalı';

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
  String get restrictions => 'Kısıtlamalar / Alerjiler';

  @override
  String get clearProfileTitle => 'Profil silinsin mi?';

  @override
  String get clearProfileDesc =>
      'Bu tüm kişisel verileri silecek ve manuel moda sıfırlayacaktır.';

  @override
  String get clear => 'Temizle';

  @override
  String get profileCleared => 'Profil başarıyla temizlendi';

  @override
  String ofTarget(Object kcal) {
    return '$kcal kcal üzerinden';
  }

  @override
  String get kcalDay => 'kcal/gün';

  @override
  String dailyTargetLabel(Object kcal) {
    return '$kcal kcal üzerinden';
  }

  @override
  String get takeSurveyDesc =>
      'Kişisel bilgiler için lütfen anketi tamamlayın.';

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
  String get restrictionsLabel => 'Kısıtlamalar / Alerjiler';

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
  String get profileSaved => 'Profil güncellendi';

  @override
  String get basicInfo => 'Temel Bilgiler';

  @override
  String get goalsAndLifestyle => 'Hedefler ve Yaşam Tarzı';

  @override
  String get preferences => 'Tercihler';

  @override
  String get location => 'Konum';

  @override
  String get next => 'İleri';

  @override
  String get settings => 'Ayarlar';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get on => 'Açık';

  @override
  String get off => 'Kapalı';

  @override
  String get language => 'Dil';

  @override
  String get currentLanguage => 'Mevcut Dil';

  @override
  String get reminders => 'Hatırlatıcılar';

  @override
  String get dailyReminderDesc => 'Günlük kalori hatırlatmaları alın';

  @override
  String get exportData => 'Veri Dışa Aktar';

  @override
  String get backupYourData => 'Kayıtlarınızı ve ilerlemenizi yedekleyin';

  @override
  String get importData => 'Veri İçe Aktar';

  @override
  String get restoreYourData => 'Yedekten verileri geri yükle';

  @override
  String get aboutApp => 'Uygulama Hakkında';

  @override
  String get aboutDesc =>
      'Yerel yiyecekler ve gizlilik odaklı çevrimdışı kalori takipçisi';

  @override
  String get manageProfiles => 'Profilleri Yönet';

  @override
  String get switchProfile => 'Profil Değiştir';

  @override
  String get noProfilesYet => 'Henüz profil yok';

  @override
  String get createNewProfile => 'Yeni Profil Oluştur';

  @override
  String get profileName => 'Profil Adı';

  @override
  String get profileNameHint => 'ör. Aile Üyesi 1';

  @override
  String get create => 'Oluştur';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get switchedTo => 'Değiştirildi';

  @override
  String get createdProfile => 'Profil oluşturuldu';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProfile => 'Profili Sil';

  @override
  String get deleteProfileDesc =>
      'Bu işlem bu profilin tüm verilerini kalıcı olarak siler. Bu işlem geri alınamaz.';

  @override
  String get profileDeleted => 'Profil silindi';

  @override
  String get selectLanguage => 'Dil Seç';

  @override
  String get selectWeightUnit => 'Ağırlık Birimi Seç';

  @override
  String get selectHeightUnit => 'Boy Birimi Seç';

  @override
  String get weightUnit => 'Ağırlık Birimi';

  @override
  String get heightUnit => 'Boy Birimi';

  @override
  String get comingSoon => 'Yakında';

  @override
  String get rateUs => 'Bizi Değerlendirin';

  @override
  String get rateUsComingSoon => 'Puanlama özelliği yakında gelecek!';

  @override
  String get joinBeta => 'Beta Test\'e Katıl';

  @override
  String get betaComingSoon => 'Beta test programı yakında gelecek!';

  @override
  String get todayCalories => 'Bugünün Kalorileri';

  @override
  String get manualEntry => 'Manuel Giriş';

  @override
  String get failedToCreateProfile => 'Profil oluşturulamadı';

  @override
  String get failedToDeleteProfile => 'Profil silinemedi';

  @override
  String get foodLogged => 'Yemek başarıyla kaydedildi';

  @override
  String get historyAndProgress => 'Geçmiş ve ilerleme';

  @override
  String get height => 'Boy';

  @override
  String get currentWeight => 'Mevcut kilo';

  @override
  String get checkingConnection => 'Bağlantı kontrol ediliyor...';

  @override
  String get noInternetConnection => 'İnternet Bağlantısı Yok';

  @override
  String get pleaseConnectToInternet =>
      'Devam etmek için lütfen internete bağlanın';

  @override
  String get tryAgain => 'Tekrar Dene';

  @override
  String get trackNutrition => 'Beslenmeni Takip Et';

  @override
  String get trackNutritionDesc =>
      'Öğünlerini kolayca kaydet ve bölgeye özel gıdalarla kalorilerini izle';

  @override
  String get trackProgress => 'Gelişimini Takip Et';

  @override
  String get trackProgressDesc =>
      'Günlük kalori alımının ve hedeflerinin grafiklerini ve geçmişini görüntüle';

  @override
  String get personalizedProfile => 'Kişiselleştirilmiş Profil';

  @override
  String get personalizedProfileDesc =>
      'Aile üyeleri için özelleştirilmiş önerilerle birden fazla profil oluşturun';

  @override
  String get getStarted => 'Hadi Başlayalım';

  @override
  String get profileSwitchedTitle => 'Profil Değiştirildi';

  @override
  String get profileSwitchedDesc =>
      'Yeni profilin tamamen uygulanması için uygulamanın yeniden başlatılması gerekiyor. Şimdi yeniden başlatılsın mı?';

  @override
  String get later => 'Sonra';

  @override
  String get restartNow => 'Şimdi Yeniden Başlat';
}
