import 'package:flutter/material.dart';
import '../tema/app_theme.dart';
import '../services/balinese_calendar_service.dart';

class NusantaraCalendarScreen extends StatefulWidget {
  const NusantaraCalendarScreen({super.key});

  @override
  State<NusantaraCalendarScreen> createState() =>
      _NusantaraCalendarScreenState();
}

class _NusantaraCalendarScreenState
    extends State<NusantaraCalendarScreen> {
  DateTime tanggalDipilih = DateTime.now();

  // =========================
  // KALENDER JAWA
  // =========================

  String hari = '';
  String pasaran = '';
  String weton = '';
  int neptu = 0;

  // =========================
  // KALENDER SAKA BALI
  // =========================

 int tahunSaka = 0;
String sasih = '';
String wukuBali = '';

  @override
  void initState() {
    super.initState();

    hitungWeton(tanggalDipilih);
    hitungSakaBali(tanggalDipilih);
  }

  // =========================================================
  // PILIH TANGGAL
  // =========================================================

  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: tanggalDipilih,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (tanggal != null) {
      setState(() {
        tanggalDipilih = tanggal;

        hitungWeton(tanggal);
        hitungSakaBali(tanggal);
      });
    }
  }

  // =========================================================
  // KALENDER JAWA / WETON
  // =========================================================

  void hitungWeton(DateTime tanggal) {
    const namaHari = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];

    const nilaiHari = [
      5, // Minggu
      4, // Senin
      3, // Selasa
      7, // Rabu
      8, // Kamis
      6, // Jumat
      9, // Sabtu
    ];

    const namaPasaran = [
      'Legi',
      'Pahing',
      'Pon',
      'Wage',
      'Kliwon',
    ];

    const nilaiPasaran = [
      5, // Legi
      9, // Pahing
      7, // Pon
      4, // Wage
      8, // Kliwon
    ];

    // Referensi:
    // 1 Januari 2025 = Rabu Pon
    final referensi = DateTime(2025, 1, 1);

    final selisih = tanggal.difference(referensi).inDays;

    final indexHari = tanggal.weekday % 7;

    int indexPasaran = (2 + selisih) % 5;

    if (indexPasaran < 0) {
      indexPasaran += 5;
    }

    hari = namaHari[indexHari];
    pasaran = namaPasaran[indexPasaran];

    weton = '$hari $pasaran';

    neptu = nilaiHari[indexHari] +
        nilaiPasaran[indexPasaran];
  }

  // =========================================================
  // KALENDER SAKA BALI
  // =========================================================

 void hitungSakaBali(DateTime tanggal) {
  final hasil = BalineseCalendarService.getCalendar(tanggal);

  print('SAKA: ${hasil.saka}');
  print('SASIH: ${hasil.sasih}');
  print('WUKU: ${hasil.wuku}');

  tahunSaka = hasil.saka;
  sasih = hasil.sasih;
  wukuBali = hasil.wuku;
}

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String formatTanggal(DateTime tanggal) {
    return '${tanggal.day.toString().padLeft(2, '0')}/'
        '${tanggal.month.toString().padLeft(2, '0')}/'
        '${tanggal.year}';
  }

  // =========================================================
  // KARTU HASIL
  // =========================================================

  Widget kartuHasil({
    required String judul,
    required String hasil,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppColors.blue,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    hasil,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalender Nusantara',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // =================================================
          // HEADER
          // =================================================

          const Text(
            'Kalender Nusantara',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.blue,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Kenali penanggalan dan budaya Nusantara.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 22),

          // =================================================
          // PILIH TANGGAL
          // =================================================

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.blue,
                    size: 40,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    formatTanggal(tanggalDipilih),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: pilihTanggal,
                      icon: const Icon(
                        Icons.edit_calendar_outlined,
                      ),
                      label: const Text(
                        'Pilih Tanggal',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =================================================
          // KALENDER JAWA
          // =================================================

          const Text(
            'Kalender Jawa',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          kartuHasil(
            judul: 'Hari',
            hasil: hari,
            icon: Icons.today_outlined,
          ),

          const SizedBox(height: 12),

          kartuHasil(
            judul: 'Pasaran',
            hasil: pasaran,
            icon: Icons.auto_awesome_outlined,
          ),

          const SizedBox(height: 12),

          kartuHasil(
            judul: 'Weton',
            hasil: weton,
            icon: Icons.stars_outlined,
          ),

          const SizedBox(height: 12),

          kartuHasil(
            judul: 'Neptu',
            hasil: neptu.toString(),
            icon: Icons.calculate_outlined,
          ),

          const SizedBox(height: 28),

          // =================================================
          // KALENDER SAKA BALI
          // =================================================

          const Text(
            'Kalender Saka Bali',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          kartuHasil(
            judul: 'Tahun Saka',
            hasil: tahunSaka.toString(),
            icon: Icons.calendar_today_outlined,
          ),

          const SizedBox(height: 12),

          kartuHasil(
            judul: 'Sasih',
            hasil: sasih,
            icon: Icons.brightness_3_outlined,
          ),

          const SizedBox(height: 12),

          kartuHasil(
            judul: 'Wuku',
            hasil: wukuBali,
            icon: Icons.auto_awesome_outlined,
          ),

          const SizedBox(height: 12),



          const SizedBox(height: 20),

          // =================================================
          // INFO
          // =================================================

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.blue,
                    size: 28,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      'Kalender Saka Bali menggunakan sistem '
                      'penanggalan tradisional Bali yang mencakup '
                      'Sasih dan Pawukon. Perhitungan lanjutan '
                      'seperti Penanggal, Panglong, dan Nampih '
                      'Sasih dapat dikembangkan pada versi berikutnya.',
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}