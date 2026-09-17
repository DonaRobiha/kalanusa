import 'package:flutter/material.dart';
import '../tema/app_theme.dart';

class TravelCalculatorScreen extends StatefulWidget {
  const TravelCalculatorScreen({super.key});

  @override
  State<TravelCalculatorScreen> createState() =>
      _TravelCalculatorScreenState();
}

class _TravelCalculatorScreenState extends State<TravelCalculatorScreen> {
  final jumlahOrangController = TextEditingController();
  final transportController = TextEditingController();
  final penginapanController = TextEditingController();
  final makanController = TextEditingController();
  final tiketController = TextEditingController();
  final lainnyaController = TextEditingController();

  double totalBiaya = 0;
  double biayaPerOrang = 0;

  double ubahKeAngka(String value) {
    return double.tryParse(value.replaceAll('.', '').replaceAll(',', '')) ?? 0;
  }

  void hitungBiaya() {
    final jumlahOrang = int.tryParse(jumlahOrangController.text) ?? 0;

    final transport = ubahKeAngka(transportController.text);
    final penginapan = ubahKeAngka(penginapanController.text);
    final makan = ubahKeAngka(makanController.text);
    final tiket = ubahKeAngka(tiketController.text);
    final lainnya = ubahKeAngka(lainnyaController.text);

    final total = transport + penginapan + makan + tiket + lainnya;

    setState(() {
      totalBiaya = total;
      biayaPerOrang = jumlahOrang > 0 ? total / jumlahOrang : 0;
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
            'Rencanakan anggaran perjalananmu dengan mudah.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 22),

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

          const SizedBox(height: 8),

          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: hitungBiaya,
              icon: const Icon(Icons.calculate_outlined),
              label: const Text(
                'Hitung Biaya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Hasil Perhitungan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Biaya'),
                      Text(
                        formatRupiah(totalBiaya),
                        style: const TextStyle(
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
                      const Text('Biaya per Orang'),
                      Text(
                        formatRupiah(biayaPerOrang),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
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