import 'package:flutter/material.dart';
import '../tema/app_theme.dart';
import '../services/api_service.dart';

class DestinasiScreen extends StatefulWidget {
  const DestinasiScreen({super.key});

  @override
  State<DestinasiScreen> createState() => _DestinasiScreenState();
}

class _DestinasiScreenState extends State<DestinasiScreen> {
  List<Map<String, dynamic>> destinasi = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _muatDestinasi();
  }

  Future<void> _muatDestinasi() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await ApiService.instance.getDestinasi();
      if (mounted) {
        setState(() {
          destinasi = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage =
              'Gagal terhubung ke MySQL XAMPP.\nPastikan Apache & MySQL di XAMPP sudah di-Start.';
        });
      }
    }
  }

  void tampilkanForm({Map<String, dynamic>? data}) {
    final namaController =
        TextEditingController(text: data?['nama']?.toString() ?? '');
    final lokasiController =
        TextEditingController(text: data?['lokasi']?.toString() ?? '');
    final kategoriController =
        TextEditingController(text: data?['kategori']?.toString() ?? '');
    final biayaController =
        TextEditingController(text: data?['biaya']?.toString() ?? '');
    final fotoController =
        TextEditingController(text: data?['foto']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: Text(
            data == null ? 'Tambah Destinasi (XAMPP)' : 'Edit Destinasi',
            style: const TextStyle(
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
                    hintText: 'Contoh: 50000 atau Rp50.000',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: fotoController,
                  decoration: const InputDecoration(
                    labelText: 'URL Foto Wisata',
                    hintText: 'https://...',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogCtx).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final nama = namaController.text.trim();
                final lokasi = lokasiController.text.trim();
                if (nama.isEmpty || lokasi.isEmpty) {
                  return;
                }

                final rowData = {
                  'nama': nama,
                  'lokasi': lokasi,
                  'kategori': kategoriController.text.trim().isEmpty
                      ? 'Wisata'
                      : kategoriController.text.trim(),
                  'biaya': biayaController.text.trim().isEmpty
                      ? '0'
                      : biayaController.text.trim(),
                  'foto': fotoController.text.trim(),
                  'deskripsi': '',
                };

                Navigator.of(dialogCtx).pop();

                try {
                  if (data == null) {
                    await ApiService.instance.tambahDestinasi(rowData);
                  } else {
                    final id = (data['id'] as num).toInt();
                    await ApiService.instance.updateDestinasi(id, rowData);
                  }

                  await _muatDestinasi();

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          data == null
                              ? 'Destinasi berhasil disimpan ke MySQL XAMPP!'
                              : 'Destinasi berhasil diperbarui di MySQL XAMPP!',
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Gagal menyimpan ke XAMPP: $e'),
                      ),
                    );
                  }
                }
              },
              child: Text(
                data == null ? 'Simpan ke XAMPP' : 'Update',
              ),
            ),
          ],
        );
      },
    );
  }

  void hapusDestinasi(int id, String nama) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Hapus Destinasi'),
        content: Text('Yakin ingin menghapus "$nama" dari database XAMPP?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.of(dialogCtx).pop();
              try {
                await ApiService.instance.hapusDestinasi(id);
                await _muatDestinasi();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Destinasi berhasil dihapus dari XAMPP'),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Gagal menghapus dari XAMPP: $e'),
                    ),
                  );
                }
              }
            },
            child: const Text('Hapus'),
          ),
        ],
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
        actions: [
          IconButton(
            tooltip: 'Refresh data dari XAMPP',
            icon: const Icon(Icons.refresh),
            onPressed: _muatDestinasi,
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.blue),
            )
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud_off_outlined,
                          size: 60,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _muatDestinasi,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _muatDestinasi,
                  child: ListView(
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
                        'Data terhubung langsung ke database MySQL XAMPP (kalanusa).',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (destinasi.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: Text(
                              'Belum ada destinasi di MySQL XAMPP. Tekan tombol + untuk menambahkan.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ),
                      ...List.generate(
                        destinasi.length,
                        (index) {
                          final data = destinasi[index];
                          final id = (data['id'] as num).toInt();
                          final fotoUrl = data['foto']?.toString() ?? '';

                          return Card(
                            margin: const EdgeInsets.only(bottom: 14),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Foto Wisata
                                  if (fotoUrl.isNotEmpty)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: Image.network(
                                        fotoUrl,
                                        height: 160,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 100,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.offWhite,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                                color: AppColors.blue,
                                                size: 40,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  if (fotoUrl.isNotEmpty)
                                    const SizedBox(height: 14),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: AppColors.blue
                                              .withValues(alpha: 0.09),
                                          borderRadius:
                                              BorderRadius.circular(14),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['nama']?.toString() ?? '',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              data['lokasi']?.toString() ?? '',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              data['kategori']?.toString() ??
                                                  '',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.blue,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Estimasi: Rp${data['biaya'] ?? '0'}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              tampilkanForm(data: data);
                                            },
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                            ),
                                            color: AppColors.blue,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              hapusDestinasi(
                                                id,
                                                data['nama']?.toString() ?? '',
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                            ),
                                            color: Colors.redAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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