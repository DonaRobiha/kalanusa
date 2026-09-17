import 'package:flutter/material.dart';
import '../tema/app_theme.dart';

class TravelPlanScreen extends StatefulWidget {
  const TravelPlanScreen({super.key});

  @override
  State<TravelPlanScreen> createState() => _TravelPlanScreenState();
}

class _TravelPlanScreenState extends State<TravelPlanScreen> {
  final List<Map<String, String>> plans = [
    {
      'tujuan': 'Yogyakarta',
      'tanggal': '20 September 2026',
      'orang': '3 orang',
      'budget': 'Rp1.500.000',
      'catatan': 'Wisata dan kuliner',
    },
  ];

  void tampilkanForm({int? index}) {
    final data = index != null ? plans[index] : null;

    final tujuanController =
        TextEditingController(text: data?['tujuan'] ?? '');
    final tanggalController =
        TextEditingController(text: data?['tanggal'] ?? '');
    final orangController =
        TextEditingController(text: data?['orang'] ?? '');
    final budgetController =
        TextEditingController(text: data?['budget'] ?? '');
    final catatanController =
        TextEditingController(text: data?['catatan'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            index == null ? 'Tambah Rencana' : 'Edit Rencana',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: tujuanController,
                  decoration: const InputDecoration(
                    labelText: 'Tujuan',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tanggalController,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Perjalanan',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: orangController,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Orang',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: budgetController,
                  decoration: const InputDecoration(
                    labelText: 'Budget',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: catatanController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (tujuanController.text.isEmpty) {
                  return;
                }

                setState(() {
                  final newData = {
                    'tujuan': tujuanController.text,
                    'tanggal': tanggalController.text,
                    'orang': orangController.text,
                    'budget': budgetController.text,
                    'catatan': catatanController.text,
                  };

                  if (index == null) {
                    plans.add(newData);
                  } else {
                    plans[index] = newData;
                  }
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      index == null
                          ? 'Rencana berhasil ditambahkan'
                          : 'Rencana berhasil diperbarui',
                    ),
                  ),
                );
              },
              child: Text(
                index == null ? 'Simpan' : 'Update',
              ),
            ),
          ],
        );
      },
    );
  }

  void hapusRencana(int index) {
    setState(() {
      plans.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rencana berhasil dihapus'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rencana Perjalanan',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Rencana Perjalananmu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.blue,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Buat dan kelola rencana perjalanan Nusantara.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 20),

          if (plans.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Text(
                  'Belum ada rencana perjalanan.',
                  style: TextStyle(
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),

          ...List.generate(
            plans.length,
            (index) {
              final plan = plans[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.offWhite,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.map_outlined,
                              color: AppColors.blue,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Text(
                              plan['tujuan'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              tampilkanForm(index: index);
                            },
                            icon: const Icon(Icons.edit_outlined),
                            color: AppColors.blue,
                          ),

                          IconButton(
                            onPressed: () {
                              hapusRencana(index);
                            },
                            icon: const Icon(Icons.delete_outline),
                            color: AppColors.blue,
                          ),
                        ],
                      ),

                      const Divider(height: 24),

                      Text(
                        '📅 ${plan['tanggal']}',
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '👥 ${plan['orang']}',
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '💰 ${plan['budget']}',
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '📝 ${plan['catatan']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tampilkanForm();
        },
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}