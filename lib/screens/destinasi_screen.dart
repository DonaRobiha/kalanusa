import 'package:flutter/material.dart';
import '../tema/app_theme.dart';

class DestinasiScreen extends StatefulWidget {
  const DestinasiScreen({super.key});

  @override
  State<DestinasiScreen> createState() => _DestinasiScreenState();
}

class _DestinasiScreenState extends State<DestinasiScreen> {
  final List<Map<String, String>> destinasi = [
    {
      'nama': 'Borobudur',
      'lokasi': 'Magelang, Jawa Tengah',
      'kategori': 'Wisata Budaya',
      'biaya': 'Rp50.000',
    },
    {
      'nama': 'Raja Ampat',
      'lokasi': 'Papua Barat Daya',
      'kategori': 'Wisata Alam',
      'biaya': 'Rp500.000',
    },
    {
      'nama': 'Bali',
      'lokasi': 'Bali',
      'kategori': 'Wisata Pantai',
      'biaya': 'Rp100.000',
    },
  ];

  void tambahDestinasi() {
    final namaController = TextEditingController();
    final lokasiController = TextEditingController();
    final kategoriController = TextEditingController();
    final biayaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Tambah Destinasi',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Destinasi',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: lokasiController,
                  decoration: const InputDecoration(
                    labelText: 'Lokasi',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: kategoriController,
                  decoration: const InputDecoration(
                    labelText: 'Kategori Wisata',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: biayaController,
                  decoration: const InputDecoration(
                    labelText: 'Estimasi Biaya',
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
                if (namaController.text.isEmpty ||
                    lokasiController.text.isEmpty) {
                  return;
                }

                setState(() {
                  destinasi.add({
                    'nama': namaController.text,
                    'lokasi': lokasiController.text,
                    'kategori': kategoriController.text,
                    'biaya': biayaController.text,
                  });
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Destinasi berhasil ditambahkan'),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void hapusDestinasi(int index) {
    setState(() {
      destinasi.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Destinasi berhasil dihapus'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Destinasi Nusantara',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Jelajahi Nusantara',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.blue,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Temukan destinasi menarik untuk perjalananmu.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 20),

          ...List.generate(
            destinasi.length,
            (index) {
              final data = destinasi[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.blue,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['nama'] ?? '',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              data['lokasi'] ?? '',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textDark,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              data['kategori'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blue,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'Estimasi: ${data['biaya'] ?? '-'}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          hapusDestinasi(index);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                        color: AppColors.blue,
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
        onPressed: tambahDestinasi,
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}