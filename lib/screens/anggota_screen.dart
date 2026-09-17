import 'package:flutter/material.dart';
import '../tema/app_theme.dart';

class AnggotaScreen extends StatelessWidget {
  const AnggotaScreen({super.key});

  final List<Map<String, String>> anggota = const [
    {
      'nama': 'Dona Robiha',
      'nim': '124240026',
    },
    {
      'nama': 'Dhini Rahayu',
      'nim': '124240197',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Anggota'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: anggota.length,
        itemBuilder: (context, index) {
          final data = anggota[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: AppColors.offWhite,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                data['nama']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              subtitle: Text(
                'NIM: ${data['nim']}',
                style: const TextStyle(
                  color: AppColors.textDark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}