import 'package:flutter/material.dart';
import '../tema/app_theme.dart';
import 'login_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tentang KALANUSA
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.blue,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Tentang KALANUSA',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'KALANUSA adalah aplikasi Travel Planner Nusantara '
                      'yang membantu pengguna merencanakan perjalanan, '
                      'mengelola destinasi, menghitung kebutuhan perjalanan, '
                      'serta mengenal berbagai informasi kalender Nusantara.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Panduan Menu
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          color: AppColors.blue,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Panduan Menu',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _panduan(
                      'Daftar Anggota',
                      'Melihat anggota kelompok yang terdaftar.',
                    ),
                    _panduan(
                      'Destinasi Nusantara',
                      'Melihat dan mengelola informasi destinasi wisata.',
                    ),
                    _panduan(
                      'Komputasi Perjalanan',
                      'Menghitung estimasi biaya perjalanan.',
                    ),
                    _panduan(
                      'Rencana Perjalanan',
                      'Membuat, mengubah, dan menghapus rencana perjalanan.',
                    ),
                    _panduan(
                      'Konversi & Waktu',
                      'Menghitung umur dan melakukan konversi tanggal.',
                    ),
                    _panduan(
                      'Kalender Nusantara',
                      'Melihat informasi Weton dan Kalender Saka Bali.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Cara menggunakan
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: AppColors.blue,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Cara Menggunakan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Login menggunakan akun yang tersedia.\n'
                      '2. Pilih menu yang ingin digunakan.\n'
                      '3. Masukkan data sesuai kebutuhan.\n'
                      '4. Gunakan tombol tambah, simpan, atau hitung '
                      'sesuai fitur yang tersedia.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tombol keluar
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Keluar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _panduan(String judul, String deskripsi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 20,
            color: AppColors.blue,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: '$judul\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: deskripsi,
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