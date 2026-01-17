// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Ahli Gizi';

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
  String remaining(Object kcal) {
    return 'Sisa: $kcal kkal';
  }

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
  String get positiveNumber => 'Angka positif';

  @override
  String get positive => 'Positif';

  @override
  String get entryDeleted => 'Entri dihapus';

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
  String get cancel => 'Batal';

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
  String get takeSurveyDesc =>
      'Lengkapi profil singkat untuk mendapatkan target kalori khusus dan rekomendasi yang lebih baik.';

  @override
  String dailyTargetLabel(Object kcal) {
    return 'dari $kcal kkal';
  }

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
}
