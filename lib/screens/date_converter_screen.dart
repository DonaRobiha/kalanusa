import 'dart:async';
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

  int? tahunUmur;
  int? bulanUmur;
  int? hariUmur;
  int? jamUmur;
  int? menitUmur;
  int? detikUmur;

  String hasilUmur = '';
  String hasilHijriah = '';

  Timer? _timerUmur;

  void _mulaiTimerUmur() {
    _timerUmur?.cancel();
    _timerUmur = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        hitungUmur();
      },
    );
  }

  Future<void> pilihTanggalLahir() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: tanggalLahir ?? DateTime(2005, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalLahir = tanggal;
        hitungUmur();
        _mulaiTimerUmur();
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
      tahunUmur = tahun;
      bulanUmur = bulan;
      hariUmur = hari;
      jamUmur = jam;
      menitUmur = menit;
      detikUmur = detik;
      hasilUmur =
          '$tahun tahun, $bulan bulan, $hari hari\n'
          '$jam jam, $menit menit, $detik detik';
    });
  }

  Future<void> pilihTanggalMasehi() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: tanggalMasehi ?? DateTime.now(),
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

  @override
  void dispose() {
    _timerUmur?.cancel();
    super.dispose();
  }

  String formatTanggal(DateTime tanggal) {
    const namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${tanggal.day} ${namaBulan[tanggal.month - 1]} ${tanggal.year}';
  }

  Widget _buildStatBox(String angka, String satuan) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.blue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.blue.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              angka,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.blue,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              satuan,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
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
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        children: [
          // Banner Info Pengantar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.blue.withValues(alpha: 0.14),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blue.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.access_time_rounded,
                    color: AppColors.blue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Kelola tanggal perjalanan, pantau durasi usia real-time, dan konversi ke kalender Hijriah.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ==========================================
          // BAGIAN 1: HITUNG USIA REAL-TIME
          // ==========================================
          Row(
            children: const [
              Icon(
                Icons.cake_rounded,
                color: AppColors.blue,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Hitung Usia Detail',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Tombol Pilih Tanggal Lahir
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: pilihTanggalLahir,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.blue.withValues(alpha: 0.18),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkBlue.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.blue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Lahir',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tanggalLahir == null
                              ? 'Ketuk untuk memilih tanggal lahir'
                              : formatTanggal(tanggalLahir!),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: tanggalLahir == null
                                ? AppColors.textGray
                                : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.blue,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Hasil Perhitungan Usia Real-Time
          if (tahunUmur != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.hourglass_bottom_rounded,
                              color: AppColors.blue,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Usia Kamu Saat Ini',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: Colors.green,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Real-Time',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _buildStatBox('$tahunUmur', 'Tahun'),
                        const SizedBox(width: 10),
                        _buildStatBox('$bulanUmur', 'Bulan'),
                        const SizedBox(width: 10),
                        _buildStatBox('$hariUmur', 'Hari'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.offWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 15,
                            color: AppColors.blue,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$jamUmur jam  •  $menitUmur menit  •  $detikUmur detik',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blue,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 26),

          // ==========================================
          // BAGIAN 2: MASEHI KE HIJRIAH
          // ==========================================
          Row(
            children: const [
              Icon(
                Icons.nights_stay_rounded,
                color: AppColors.blue,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Konversi Masehi ke Hijriah',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Tombol Pilih Tanggal Masehi
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: pilihTanggalMasehi,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.blue.withValues(alpha: 0.18),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkBlue.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.event_note_rounded,
                      color: AppColors.blue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Masehi',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tanggalMasehi == null
                              ? 'Ketuk untuk memilih tanggal Masehi'
                              : formatTanggal(tanggalMasehi!),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: tanggalMasehi == null
                                ? AppColors.textGray
                                : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.blue,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Hasil Konversi Hijriah
          if (hasilHijriah.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.blue.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.brightness_2_rounded,
                        color: AppColors.blue,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Penanggalan Hijriah',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hasilHijriah,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.blue,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}