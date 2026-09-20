class BalineseCalendarData {
  final int saka;
  final String sasih;
  final String wuku;

  const BalineseCalendarData({
    required this.saka,
    required this.sasih,
    required this.wuku,
  });
}

class BalineseCalendarService {
  // Daftar 12 Sasih (bulan lunar Bali)
  static const List<String> _namaSasih = [
    'Kadasa',
    'Jiyesta',
    'Sadha',
    'Kasa',
    'Karo',
    'Katiga',
    'Kapat',
    'Kalima',
    'Kanem',
    'Kapitu',
    'Kawolu',
    'Kasanga',
  ];

  // Daftar 30 Wuku dalam siklus Pawukon (210 hari)
  static const List<String> _namaWuku = [
    'Sinta',
    'Landep',
    'Ukir',
    'Kulantir',
    'Tolu',
    'Gumbreg',
    'Wariga',
    'Warigadean',
    'Julungwangi',
    'Sungsang',
    'Dungulan',
    'Kuningan',
    'Langkir',
    'Medangsia',
    'Pujut',
    'Pahang',
    'Krulut',
    'Merakih',
    'Tambir',
    'Medangkungan',
    'Matal',
    'Uye',
    'Menail',
    'Prangbakat',
    'Bala',
    'Ugu',
    'Wayang',
    'Klawu',
    'Dukut',
    'Watugunung',
  ];

  static BalineseCalendarData getCalendar(DateTime tanggal) {
    // ============================
    // TAHUN SAKA
    // ============================
    // Tahun Saka Bali = Masehi - 78
    // Tahun Saka baru dimulai saat Nyepi (sekitar Maret/April).
    // Untuk penyederhanaan, gunakan batas bulan Maret.
    int tahunSaka = tanggal.year - 78;
    if (tanggal.month < 3) {
      tahunSaka -= 1;
    }

    // ============================
    // SASIH (Bulan Lunar Bali)
    // ============================
    // Referensi: Nyepi 1947 Saka jatuh pada 29 Maret 2025
    // Nyepi menandai awal Sasih Kadasa (sasih ke-0/10 dalam tahun Saka baru)
    // Satu siklus Sasih ≈ 29.53 hari (synodic month)
    final referensiSasih = DateTime(2025, 3, 29);
    final selisihHariSasih = tanggal.difference(referensiSasih).inDays;

    const double siklusBulanLunar = 29.53059;

    int indexSasih;
    if (selisihHariSasih >= 0) {
      indexSasih = (selisihHariSasih / siklusBulanLunar).floor() % 12;
    } else {
      final totalBulanNegatif =
          (selisihHariSasih.abs() / siklusBulanLunar).ceil();
      indexSasih = (12 - (totalBulanNegatif % 12)) % 12;
    }

    final sasih = _namaSasih[indexSasih];

    // ============================
    // WUKU (Siklus Pawukon 210 Hari)
    // ============================
    // Siklus Pawukon = 30 wuku × 7 hari = 210 hari
    // Referensi: 4 Januari 2025 = Wuku Sinta hari ke-1
    final referensiWuku = DateTime(2025, 1, 4);
    final selisihHariWuku = tanggal.difference(referensiWuku).inDays;

    int indexWuku;
    if (selisihHariWuku >= 0) {
      indexWuku = ((selisihHariWuku % 210) ~/ 7) % 30;
    } else {
      final hariDalamSiklus = 210 - (selisihHariWuku.abs() % 210);
      indexWuku = ((hariDalamSiklus % 210) ~/ 7) % 30;
    }

    final wuku = _namaWuku[indexWuku];

    return BalineseCalendarData(
      saka: tahunSaka,
      sasih: sasih,
      wuku: wuku,
    );
  }
}