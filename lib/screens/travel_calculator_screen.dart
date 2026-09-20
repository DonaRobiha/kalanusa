import 'package:flutter/material.dart';
import '../tema/app_theme.dart';
import '../services/api_service.dart';
import '../database/database_helper.dart';
import 'travel_plan_screen.dart';

class TravelCalculatorScreen extends StatefulWidget {
  const TravelCalculatorScreen({super.key});

  @override
  State<TravelCalculatorScreen> createState() =>
      _TravelCalculatorScreenState();
}

class _TravelCalculatorScreenState extends State<TravelCalculatorScreen> {
  final namaRencanaController = TextEditingController();
  final tglRencanaController = TextEditingController();
  final jumlahOrangController = TextEditingController();
  final transportController = TextEditingController();
  final penginapanController = TextEditingController();
  final makanController = TextEditingController();
  final tiketController = TextEditingController();
  final lainnyaController = TextEditingController();

  List<Map<String, dynamic>> daftarDestinasi = [];
  Map<String, dynamic>? selectedDestinasi;
  bool isLoadingDestinasi = false;

  bool sudahDihitung = false;
  bool isSaving = false;

  double totalBiaya = 0;
  double biayaPerOrang = 0;

  @override
  void initState() {
    super.initState();
    _muatDataDestinasi();
  }

  Future<void> _muatDataDestinasi() async {
    setState(() {
      isLoadingDestinasi = true;
    });

    try {
      final apiData = await ApiService.instance.getDestinasi();
      if (apiData.isNotEmpty) {
        if (mounted) {
          setState(() {
            daftarDestinasi = List<Map<String, dynamic>>.from(apiData);
            isLoadingDestinasi = false;
          });
        }
        return;
      }
    } catch (_) {
      // Fallback ke database lokal SQLite jika XAMPP tidak aktif
    }

    try {
      final localData = await DatabaseHelper.instance.getDestinasi();
      if (mounted) {
        setState(() {
          daftarDestinasi = List<Map<String, dynamic>>.from(localData);
          isLoadingDestinasi = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          isLoadingDestinasi = false;
        });
      }
    }
  }

  double ubahKeAngka(String value) {
    return double.tryParse(value.replaceAll('.', '').replaceAll(',', '')) ?? 0;
  }

  double parseBiayaTiket(dynamic val) {
    if (val == null) return 0;
    String str = val.toString().trim();
    str = str.replaceAll('Rp', '').replaceAll('rp', '').replaceAll(' ', '').trim();
    if (str.contains('.') && str.endsWith('.00')) {
      str = str.substring(0, str.length - 3);
    }
    str = str.replaceAll('.', '').replaceAll(',', '');
    return double.tryParse(str) ?? 0;
  }

  Future<void> _pilihTanggal() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      final namaBulan = [
        '',
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
        'Desember'
      ];
      setState(() {
        tglRencanaController.text =
            '${picked.day} ${namaBulan[picked.month]} ${picked.year}';
      });
    }
  }

  void _onDestinasiDipilih(Map<String, dynamic>? item) {
    setState(() {
      selectedDestinasi = item;
      if (item != null) {
        if (namaRencanaController.text.trim().isEmpty) {
          namaRencanaController.text = 'Liburan ke ${item['nama']}';
        }
        final hargaSatuan = parseBiayaTiket(item['biaya']);
        final jumlahOrang = int.tryParse(jumlahOrangController.text) ?? 1;
        final totalTiket = hargaSatuan * (jumlahOrang > 0 ? jumlahOrang : 1);
        tiketController.text = totalTiket > 0 ? totalTiket.toInt().toString() : '0';
      }
      sudahDihitung = false;
    });
  }

  Future<void> simpanDanHitungHasil() async {
    final jumlahOrang = int.tryParse(jumlahOrangController.text) ?? 1;
    final transport = ubahKeAngka(transportController.text);
    final penginapan = ubahKeAngka(penginapanController.text);
    final makan = ubahKeAngka(makanController.text);
    final tiket = ubahKeAngka(tiketController.text);
    final lainnya = ubahKeAngka(lainnyaController.text);

    final total = transport + penginapan + makan + tiket + lainnya;

    if (total <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan rincian biaya terlebih dahulu.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final namaTrip = namaRencanaController.text.trim().isEmpty
        ? (selectedDestinasi != null
            ? 'Liburan ke ${selectedDestinasi!['nama']}'
            : 'Rencana Perjalanan')
        : namaRencanaController.text.trim();

    final tglLiburan = tglRencanaController.text.trim().isEmpty
        ? 'Segera'
        : tglRencanaController.text.trim();

    final hitungBiayaPerOrang = jumlahOrang > 0 ? total / jumlahOrang : total;

    setState(() {
      isSaving = true;
    });

    final rincianList = <String>[];
    if (transport > 0) rincianList.add('Transport: ${formatRupiah(transport)}');
    if (penginapan > 0) rincianList.add('Penginapan: ${formatRupiah(penginapan)}');
    if (makan > 0) rincianList.add('Makan: ${formatRupiah(makan)}');
    if (tiket > 0) rincianList.add('Tiket: ${formatRupiah(tiket)}');
    if (lainnya > 0) rincianList.add('Lainnya: ${formatRupiah(lainnya)}');
    rincianList.add('(${formatRupiah(hitungBiayaPerOrang)} / orang)');

    final rowData = {
      'tujuan': namaTrip,
      'tanggal': tglLiburan,
      'orang': '$jumlahOrang orang',
      'budget': formatRupiah(total),
      'catatan': rincianList.join(' • '),
    };

    try {
      await ApiService.instance.tambahRencana(rowData);
    } catch (_) {}

    try {
      await DatabaseHelper.instance.tambahRencana(rowData);
    } catch (_) {}

    if (mounted) {
      setState(() {
        totalBiaya = total;
        biayaPerOrang = hitungBiayaPerOrang;
        sudahDihitung = true;
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Perhitungan berhasil dihitung dan disimpan ke Rencana Perjalanan!',
          ),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Lihat',
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TravelPlanScreen(),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  void resetForm() {
    namaRencanaController.clear();
    tglRencanaController.clear();
    jumlahOrangController.clear();
    transportController.clear();
    penginapanController.clear();
    makanController.clear();
    tiketController.clear();
    lainnyaController.clear();

    setState(() {
      selectedDestinasi = null;
      totalBiaya = 0;
      biayaPerOrang = 0;
      sudahDihitung = false;
    });
  }

  String formatRupiah(double angka) {
    return 'Rp ${angka.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)}.',
        )}';
  }

  Widget inputBiaya(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: AppColors.blue,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaRencanaController.dispose();
    tglRencanaController.dispose();
    jumlahOrangController.dispose();
    transportController.dispose();
    penginapanController.dispose();
    makanController.dispose();
    tiketController.dispose();
    lainnyaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Komputasi Perjalanan',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Lihat Hasil Komputasi & Rencana',
            icon: const Icon(Icons.list_alt_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TravelPlanScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Hitung Biaya Perjalanan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.blue,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Masukkan rincian kebutuhan perjalanan. Klik simpan untuk melihat hasil komputasi dan menyimpannya ke rencana perjalanan.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 20),

          // Nama Transaksi / Rencana
          TextField(
            controller: namaRencanaController,
            decoration: const InputDecoration(
              labelText: 'Nama Perjalanan / Tujuan',
              hintText: 'Contoh: Liburan Keluarga ke Bali',
              prefixIcon: Icon(
                Icons.place_outlined,
                color: AppColors.blue,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Tanggal Rencana Liburan
          TextField(
            controller: tglRencanaController,
            readOnly: true,
            onTap: _pilihTanggal,
            decoration: const InputDecoration(
              labelText: 'Tanggal Rencana Liburan',
              hintText: 'Pilih tanggal keberangkatan liburan',
              prefixIcon: Icon(
                Icons.calendar_today_outlined,
                color: AppColors.blue,
              ),
              suffixIcon: Icon(Icons.arrow_drop_down),
            ),
          ),

          const SizedBox(height: 14),

          // Pilihan Sumber Data Destinasi (Autofill Tiket)
          DropdownButtonFormField<Map<String, dynamic>>(
            key: ValueKey(selectedDestinasi),
            initialValue: selectedDestinasi,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Pilih Destinasi Wisata (Data Otomatis)',
              prefixIcon: const Icon(
                Icons.location_city_outlined,
                color: AppColors.blue,
              ),
              suffixIcon: isLoadingDestinasi
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : null,
              helperText:
                  'Tiket masuk akan otomatis terisi berdasarkan destinasi yang dipilih',
              helperMaxLines: 2,
            ),
            items: [
              const DropdownMenuItem<Map<String, dynamic>>(
                value: null,
                child: Text('Input Manual / Kustom (Tanpa Destinasi)'),
              ),
              ...daftarDestinasi.map((item) {
                final nama = item['nama']?.toString() ?? 'Destinasi';
                final lokasi = item['lokasi']?.toString() ?? '';
                final biaya = item['biaya']?.toString() ?? '0';
                return DropdownMenuItem<Map<String, dynamic>>(
                  value: item,
                  child: Text(
                    '$nama ($lokasi) - Rp$biaya',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
            ],
            onChanged: _onDestinasiDipilih,
          ),

          const SizedBox(height: 16),

          TextField(
            controller: jumlahOrangController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Jumlah Orang',
              prefixIcon: Icon(
                Icons.people_outline,
                color: AppColors.blue,
              ),
            ),
          ),

          const SizedBox(height: 14),

          inputBiaya(
            'Transportasi',
            transportController,
            Icons.directions_car_outlined,
          ),

          inputBiaya(
            'Penginapan',
            penginapanController,
            Icons.hotel_outlined,
          ),

          inputBiaya(
            'Makan',
            makanController,
            Icons.restaurant_outlined,
          ),

          inputBiaya(
            'Tiket / Aktivitas',
            tiketController,
            Icons.confirmation_num_outlined,
          ),

          inputBiaya(
            'Biaya Lainnya',
            lainnyaController,
            Icons.more_horiz,
          ),

          const SizedBox(height: 10),

          // Tombol Aksi Simpan & Hitung
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: isSaving ? null : simpanDanHitungHasil,
                    icon: isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(
                      isSaving ? 'Menyimpan...' : 'Simpan & Hitung Biaya',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: resetForm,
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // HASIL PERHITUNGAN (Hanya muncul jika sudah klik Simpan)
          if (sudahDihitung) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.blue.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: AppColors.blue,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Hasil Perhitungan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Tersimpan ke rencana perjalanan.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Biaya',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          formatRupiah(totalBiaya),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Biaya per Orang',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          formatRupiah(biayaPerOrang),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.offWhite,
                          foregroundColor: AppColors.blue,
                          elevation: 0,
                          side: const BorderSide(color: AppColors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TravelPlanScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text(
                          'Buka Hasil Komputasi & Rencana',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}