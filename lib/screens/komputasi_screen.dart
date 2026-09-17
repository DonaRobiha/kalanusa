import 'package:flutter/material.dart';
import '../tema/app_theme.dart';

class KomputasiScreen extends StatefulWidget {
  const KomputasiScreen({super.key});

  @override
  State<KomputasiScreen> createState() => _KomputasiScreenState();
}

class _KomputasiScreenState extends State<KomputasiScreen> {
  final TextEditingController angka1Controller = TextEditingController();
  final TextEditingController angka2Controller = TextEditingController();

  String operasi = 'Penjumlahan';
  String hasil = '';

  void hitung() {
    final double? angka1 = double.tryParse(angka1Controller.text);
    final double? angka2 = double.tryParse(angka2Controller.text);

    if (angka1 == null || angka2 == null) {
      setState(() {
        hasil = 'Masukkan angka yang valid.';
      });
      return;
    }

    double hasilHitung;

    switch (operasi) {
      case 'Pengurangan':
        hasilHitung = angka1 - angka2;
        break;

      case 'Perkalian':
        hasilHitung = angka1 * angka2;
        break;

      case 'Pembagian':
        if (angka2 == 0) {
          setState(() {
            hasil = 'Tidak dapat membagi dengan 0.';
          });
          return;
        }
        hasilHitung = angka1 / angka2;
        break;

      default:
        hasilHitung = angka1 + angka2;
    }

    setState(() {
      hasil = hasilHitung % 1 == 0
          ? hasilHitung.toInt().toString()
          : hasilHitung.toString();
    });
  }

  void reset() {
    angka1Controller.clear();
    angka2Controller.clear();

    setState(() {
      hasil = '';
      operasi = 'Penjumlahan';
    });
  }

  @override
  void dispose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komputasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Komputasi Angka',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.blue,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Lakukan perhitungan menggunakan operasi dasar.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: angka1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Angka pertama',
                prefixIcon: Icon(Icons.looks_one_outlined),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: angka2Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Angka kedua',
                prefixIcon: Icon(Icons.looks_two_outlined),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: operasi,
              decoration: const InputDecoration(
                labelText: 'Operasi',
                prefixIcon: Icon(Icons.calculate_outlined),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Penjumlahan',
                  child: Text('Penjumlahan (+)'),
                ),
                DropdownMenuItem(
                  value: 'Pengurangan',
                  child: Text('Pengurangan (-)'),
                ),
                DropdownMenuItem(
                  value: 'Perkalian',
                  child: Text('Perkalian (×)'),
                ),
                DropdownMenuItem(
                  value: 'Pembagian',
                  child: Text('Pembagian (÷)'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    operasi = value;
                  });
                }
              },
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: hitung,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Hitung'),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: reset,
                  child: const Text('Reset'),
                ),
              ],
            ),

            const SizedBox(height: 25),

            if (hasil.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.functions,
                        color: AppColors.blue,
                        size: 30,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hasil',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              hasil,
                              style: const TextStyle(
                                fontSize: 26,
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
              ),
          ],
        ),
      ),
    );
  }
}