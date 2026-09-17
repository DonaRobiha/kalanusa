import 'package:flutter/material.dart';
import '../tema/app_theme.dart';

class DateConverterScreen extends StatefulWidget {
  const DateConverterScreen({super.key});

  @override
  State<DateConverterScreen> createState() => _DateConverterScreenState();
}

class _DateConverterScreenState extends State<DateConverterScreen> {
  DateTime? tanggalLahir;
  DateTime? tanggalMasehi;

  String hasilUmur = '';
  String hasilHijriah = '';

  Future<void> pilihTanggalLahir() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalLahir = tanggal;
        hitungUmur();
      });
    }
  }

  void hitungUmur() {
    if (tanggalLahir == null) return;

    final sekarang = DateTime.now();
    final lahir = tanggalLahir!;

    int tahun = sekarang.year - lahir.year;
    int bulan = sekarang.month - lahir.month;
    int hari = sekarang.day - lahir.day;

    if (hari < 0) {
      bulan--;
      final hariBulanSebelumnya =
          DateTime(sekarang.year, sekarang.month, 0).day;
      hari += hariBulanSebelumnya;
    }

    if (bulan < 0) {
      tahun--;
      bulan += 12;
    }

    final totalDurasi = sekarang.difference(lahir);

    final totalDetik = totalDurasi.inSeconds;
    final totalMenit = totalDurasi.inMinutes;
    final totalJam = totalDurasi.inHours;

    final detik = totalDetik % 60;
    final menit = totalMenit % 60;
    final jam = totalJam % 24;

    setState(() {
      hasilUmur =
          '$tahun tahun, $bulan bulan, $hari hari\n'
          '$jam jam, $menit menit, $detik detik';
    });
  }

  Future<void> pilihTanggalMasehi() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (tanggal != null) {
      setState(() {
        tanggalMasehi = tanggal;
        hasilHijriah = konversiHijriah(tanggal);
      });
    }
  }

  String konversiHijriah(DateTime tanggal) {
    // Konversi pendekatan kalender Hijriah
    final jd = tanggal.millisecondsSinceEpoch / 86400000 + 2440587.5;

    final z = (jd - 1948439.5 + 10632).floor();
    final n = ((z - 1) / 10631).floor();

    final a = z - 10631 * n + 354;
    final b =
        ((10985 - a) / 5316).floor() *
                ((50 * a / 17719).floor()) +
            (a / 5670).floor() *
                ((43 * a / 15238).floor());

    final c =
        a -
        ((30 - b) / 15).floor() * ((17719 * b) / 50).floor() -
        (b / 16).floor() * ((15238 * b) / 43).floor() +
        29;

    final d = (24 * c / 709).floor();
    final e = (c / 709).floor();

    final tahun = 30 * n + b - 30;
    final bulan = d;
    final hari = c - (709 * d / 24).floor();

    const namaBulan = [
      'Muharram',
      'Safar',
      'Rabiul Awal',
      'Rabiul Akhir',
      'Jumadil Awal',
      'Jumadil Akhir',
      'Rajab',
      'Syaban',
      'Ramadan',
      'Syawal',
      'Dzulqaidah',
      'Dzulhijjah',
    ];

    final nama = bulan >= 1 && bulan <= 12
        ? namaBulan[bulan - 1]
        : '-';

    return '$hari $nama $tahun H';
  }

  String formatTanggal(DateTime tanggal) {
    return '${tanggal.day.toString().padLeft(2, '0')}/'
        '${tanggal.month.toString().padLeft(2, '0')}/'
        '${tanggal.year}';
  }

  Widget kartuHasil({
    required String judul,
    required String isi,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppColors.blue,
              size: 28,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isi,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konversi & Waktu',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Konversi & Waktu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.blue,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Kelola tanggal dan hitung usia dengan mudah.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Tanggal Lahir → Umur',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: pilihTanggalLahir,
              icon: const Icon(Icons.cake_outlined),
              label: Text(
                tanggalLahir == null
                    ? 'Pilih Tanggal Lahir'
                    : formatTanggal(tanggalLahir!),
              ),
            ),
          ),

          const SizedBox(height: 14),

          if (hasilUmur.isNotEmpty)
            kartuHasil(
              judul: 'Usia Saat Ini',
              isi: hasilUmur,
              icon: Icons.access_time,
            ),

          const SizedBox(height: 24),

          const Text(
            'Masehi → Hijriah',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: pilihTanggalMasehi,
              icon: const Icon(Icons.calendar_month_outlined),
              label: Text(
                tanggalMasehi == null
                    ? 'Pilih Tanggal Masehi'
                    : formatTanggal(tanggalMasehi!),
              ),
            ),
          ),

          const SizedBox(height: 14),

          if (hasilHijriah.isNotEmpty)
            kartuHasil(
              judul: 'Hasil Kalender Hijriah',
              isi: hasilHijriah,
              icon: Icons.public_outlined,
            ),
        ],
      ),
    );
  }
}