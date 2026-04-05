// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'VitaCalo';

  @override
  String get logFood => 'Catat Makanan';

  @override
  String get dashboard => 'Dasbor';

  @override
  String get yourProfile => 'Profil Anda';

  @override
  String get commonFoods => 'Makanan Umum';

  @override
  String get searchFoods => 'Cari makanan...';

  @override
  String today(Object kcal) {
    return 'Hari ini: $kcal kkal';
  }

  @override
  String get remaining => 'Tersisa';

  @override
  String get newDayMessage => 'Hari baru dimulai — kalori direset ke 0';

  @override
  String get loggedToday => 'Dicatat hari ini';

  @override
  String get noFoodToday => 'Belum ada makanan yang dicatat hari ini';

  @override
  String get addFood => 'Tambah Makanan';

  @override
  String get foodName => 'Nama Makanan';

  @override
  String get caloriesPerServing => 'Kalori (per porsi)';

  @override
  String get quantity => 'Jumlah';

  @override
  String get mealCategory => 'Kategori Makan';

  @override
  String get done => 'Selesai';

  @override
  String get manualModeActive => 'Mode Manual Aktif';

  @override
  String get manualModeDesc =>
      'Anda melacak kalori tanpa target yang dipersonalisasi.\nCatat makanan secara bebas — Anda dapat mengisi survei kapan saja untuk mendapatkan target khusus.';

  @override
  String get logFoodButton => 'Catat Makanan';

  @override
  String get switchToPersonalized =>
      'Beralih ke Mode Personalisasi (Isi Survei)';

  @override
  String get dailyProgress => 'Progres Harian';

  @override
  String get goodPace => 'Kecepatan bagus — lanjutkan!';

  @override
  String get almostThere => 'Hampir tercapai — tetap waspada';

  @override
  String get overTarget =>
      'Melebihi target — pertimbangkan pilihan lebih ringan';

  @override
  String get editProfile => 'Edit Profil';

  @override
  String get startFresh => 'Mulai Ulang (Hapus Profil)';

  @override
  String get personalizeJourney => 'Personalisasi perjalanan Anda';

  @override
  String get takeSurvey => 'Isi Survei Profil';

  @override
  String get continueManual => 'Lanjutkan Mode Manual';

  @override
  String get foodAdded => 'Makanan ditambahkan!';

  @override
  String get entryDeleted => 'Entri dihapus';

  @override
  String get all => 'Semua';

  @override
  String get breakfast => 'Sarapan';

  @override
  String get lunch => 'Makan Siang';

  @override
  String get dinner => 'Makan Malam';

  @override
  String get snack => 'Camilan';

  @override
  String get fruit => 'Buah';

  @override
  String get dessert => 'Hidangan Penutup';

  @override
  String get drink => 'Minuman';

  @override
  String get allRegions => 'Semua Wilayah';

  @override
  String get pakistan => 'Pakistan';

  @override
  String get india => 'India';

  @override
  String get saudiArabia => 'Arab Saudi';

  @override
  String get uae => 'Uni Emirat Arab';

  @override
  String get usa => 'Amerika Serikat';

  @override
  String get uk => 'Inggris';

  @override
  String get germany => 'Jerman';

  @override
  String get france => 'Prancis';

  @override
  String get spain => 'Spanyol';

  @override
  String get indonesia => 'Indonesia';

  @override
  String get turkey => 'Turki';

  @override
  String get required => 'Wajib';

  @override
  String get positiveNumber => 'Harus berupa angka positif';

  @override
  String get positive => 'Harus positif';

  @override
  String get unknown => 'Tidak diketahui';

  @override
  String get kcal => 'kkal';

  @override
  String get caloriesHelper => 'Perkiraan sudah cukup — gunakan opsi di atas';

  @override
  String get target => 'Target';

  @override
  String get goal => 'Tujuan';

  @override
  String get activity => 'Aktivitas';

  @override
  String get targetWeight => 'Berat Target';

  @override
  String get dietaryPreference => 'Preferensi Diet';

  @override
  String get restrictions => 'Pembatasan';

  @override
  String get clearProfileTitle => 'Hapus Profil?';

  @override
  String get clearProfileDesc =>
      'Ini akan menghapus semua informasi profil dan catatan kalori yang tersimpan. Anda dapat mengisi survei lagi untuk memulai dari awal.';

  @override
  String get clear => 'Hapus';

  @override
  String get profileCleared => 'Profil dan catatan dihapus';

  @override
  String ofTarget(Object kcal) {
    return 'dari $kcal kkal';
  }

  @override
  String get kcalDay => 'kkal/hari';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'dari $kcal kkal';
  }

  @override
  String get takeSurveyDesc =>
      'Lengkapi profil singkat untuk mendapatkan target kalori khusus dan rekomendasi yang lebih baik.';

  @override
  String get age => 'Usia';

  @override
  String get gender => 'Jenis Kelamin';

  @override
  String get heightCm => 'Tinggi (cm)';

  @override
  String get currentWeightKg => 'Berat Saat Ini (kg)';

  @override
  String get targetWeightKgOptional => 'Berat Target (kg) — opsional';

  @override
  String get targetWeightHelper => 'Biarkan kosong jika belum yakin';

  @override
  String get mainGoal => 'Tujuan Utama';

  @override
  String get activityLevel => 'Tingkat Aktivitas';

  @override
  String get restrictionsLabel => 'Alergi, intoleransi, atau kondisi medis?';

  @override
  String get restrictionsHelper =>
      'Contoh: intoleransi laktosa, diabetes, alergi kacang… (opsional)';

  @override
  String get guidanceQuestion => 'Seberapa banyak panduan yang Anda inginkan?';

  @override
  String get guidanceLow => 'Saya tahu dasar-dasarnya';

  @override
  String get guidanceMedium => 'Di antara keduanya';

  @override
  String get guidanceHigh => 'Bimbing saya secara ketat';

  @override
  String get regionCountry => 'Wilayah / Negara';

  @override
  String get regionHelper =>
      'Membantu menampilkan makanan dan saran lokal yang relevan';

  @override
  String get saveContinue => 'Simpan & Lanjutkan';

  @override
  String get skipManual => 'Lewati → Mode Manual';

  @override
  String get updateProfileTitle => 'Perbarui Profil?';

  @override
  String get updateProfileDesc =>
      'Anda sudah memiliki profil tersimpan. Memperbarui akan menggantikan informasi lama. Lanjutkan?';

  @override
  String get update => 'Perbarui';

  @override
  String get profileSaved => 'Profil berhasil disimpan';

  @override
  String get basicInfo => 'Informasi Dasar';

  @override
  String get goalsAndLifestyle => 'Tujuan & Gaya Hidup';

  @override
  String get preferences => 'Preferensi';

  @override
  String get location => 'Lokasi';

  @override
  String get next => 'Lanjut';

  @override
  String get settings => 'Pengaturan';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get on => 'Aktif';

  @override
  String get off => 'Nonaktif';

  @override
  String get language => 'Bahasa';

  @override
  String get currentLanguage => 'Bahasa Saat Ini';

  @override
  String get reminders => 'Pengingat';

  @override
  String get dailyReminderDesc => 'Dapatkan pengingat kalori harian';

  @override
  String get exportData => 'Ekspor Data';

  @override
  String get backupYourData => 'Cadangkan log dan progres Anda';

  @override
  String get importData => 'Impor Data';

  @override
  String get restoreYourData => 'Pulihkan data dari cadangan';

  @override
  String get aboutApp => 'Tentang Aplikasi';

  @override
  String get aboutDesc =>
      'Pelacak kalori offline dengan makanan lokal dan fokus pada privasi';

  @override
  String get manageProfiles => 'Kelola Profil';

  @override
  String get switchProfile => 'Ganti Profil';

  @override
  String get noProfilesYet => 'Belum ada profil';

  @override
  String get createNewProfile => 'Buat Profil Baru';

  @override
  String get profileName => 'Nama Profil';

  @override
  String get profileNameHint => 'mis. Anggota Keluarga 1';

  @override
  String get create => 'Buat';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get switchedTo => 'Dialihkan ke';

  @override
  String get createdProfile => 'Profil dibuat';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProfile => 'Delete Profile';

  @override
  String get deleteProfileDesc =>
      'This will permanently delete all data for this profile. This action cannot be undone.';

  @override
  String get profileDeleted => 'Profile deleted';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectWeightUnit => 'Select Weight Unit';

  @override
  String get selectHeightUnit => 'Select Height Unit';

  @override
  String get weightUnit => 'Weight Unit';

  @override
  String get heightUnit => 'Height Unit';

  @override
  String get comingSoon => 'Segera hadir';

  @override
  String get rateUs => 'Nilai Kami';

  @override
  String get rateUsComingSoon => 'Fitur rating akan segera tersedia!';

  @override
  String get joinBeta => 'Bergabung dengan Pengujian Beta';

  @override
  String get betaComingSoon => 'Program beta testing akan segera diluncurkan!';

  @override
  String get todayCalories => 'Kalori Hari Ini';

  @override
  String get manualEntry => 'Entri Manual';

  @override
  String get failedToCreateProfile => 'Gagal membuat profil';

  @override
  String get failedToDeleteProfile => 'Gagal menghapus profil';

  @override
  String get foodLogged => 'Makanan berhasil dicatat';

  @override
  String get historyAndProgress => 'History & Progress';

  @override
  String get height => 'Height';

  @override
  String get currentWeight => 'Current Weight';

  @override
  String get checkingConnection => 'Memeriksa koneksi...';

  @override
  String get noInternetConnection => 'Tidak Ada Koneksi Internet';

  @override
  String get pleaseConnectToInternet =>
      'Silakan hubungkan ke internet untuk melanjutkan';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get trackNutrition => 'Pantau Nutrisi Anda';

  @override
  String get trackNutritionDesc =>
      'Catat makanan dengan mudah dan pantau kalori dengan makanan khas daerah';

  @override
  String get trackProgress => 'Pantau Progres Anda';

  @override
  String get trackProgressDesc =>
      'Lihat grafik ve riwayat asupan kalori harian dan target Anda';

  @override
  String get personalizedProfile => 'Profil Personalisasi';

  @override
  String get personalizedProfileDesc =>
      'Buat beberapa profil untuk anggota keluarga dengan rekomendasi khusus';

  @override
  String get getStarted => 'Mulai';

  @override
  String get profileSwitchedTitle => 'Profil Diganti';

  @override
  String get profileSwitchedDesc =>
      'Aplikasi perlu dimulai ulang untuk menerapkan profil baru sepenuhnya. Mulai ulang sekarang?';

  @override
  String get later => 'Nanti';

  @override
  String get restartNow => 'Mulai Ulang Sekarang';
}
