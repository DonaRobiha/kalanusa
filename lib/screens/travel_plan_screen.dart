import 'package:flutter/material.dart';
import '../tema/app_theme.dart';
import '../services/api_service.dart';
import '../database/database_helper.dart';

class _RincianItem {
  final String label;
  final String nilai;
  final IconData icon;

  const _RincianItem({
    required this.label,
    required this.nilai,
    required this.icon,
  });
}

class TravelPlanScreen extends StatefulWidget {
  const TravelPlanScreen({super.key});

  @override
  State<TravelPlanScreen> createState() => _TravelPlanScreenState();
}

class _TravelPlanScreenState extends State<TravelPlanScreen> {
  List<Map<String, dynamic>> plans = [];
  bool isLoading = true;
  String? errorMessage;
  final Set<int> _expandedIds = {};

  @override
  void initState() {
    super.initState();
    _muatRencana();
  }

  Future<void> _muatRencana() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await ApiService.instance.getRencana();
      if (data.isNotEmpty) {
        if (mounted) {
          setState(() {
            plans = List<Map<String, dynamic>>.from(data);
            isLoading = false;
          });
        }
        return;
      }
    } catch (_) {
      // Fallback ke SQLite jika XAMPP belum aktif
    }

    try {
      final localData = await DatabaseHelper.instance.getRencana();
      if (mounted) {
        setState(() {
          plans = List<Map<String, dynamic>>.from(localData);
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Gagal memuat data hasil komputasi perjalanan.';
        });
      }
    }
  }

  List<_RincianItem> _ekstrakRincianBiaya(String? catatan) {
    if (catatan == null || catatan.trim().isEmpty) return [];

    final List<_RincianItem> items = [];
    final parts =
        catatan.split('•').map((s) => s.trim()).where((s) => s.isNotEmpty);

    for (final part in parts) {
      if (part.startsWith('Transport:')) {
        items.add(_RincianItem(
          label: 'Transportasi',
          nilai: part.replaceFirst('Transport:', '').trim(),
          icon: Icons.directions_car_outlined,
        ));
      } else if (part.startsWith('Penginapan:')) {
        items.add(_RincianItem(
          label: 'Penginapan / Hotel',
          nilai: part.replaceFirst('Penginapan:', '').trim(),
          icon: Icons.hotel_outlined,
        ));
      } else if (part.startsWith('Makan:')) {
        items.add(_RincianItem(
          label: 'Konsumsi & Makan',
          nilai: part.replaceFirst('Makan:', '').trim(),
          icon: Icons.restaurant_outlined,
        ));
      } else if (part.startsWith('Tiket:')) {
        items.add(_RincianItem(
          label: 'Tiket & Aktivitas',
          nilai: part.replaceFirst('Tiket:', '').trim(),
          icon: Icons.confirmation_num_outlined,
        ));
      } else if (part.startsWith('Lainnya:')) {
        items.add(_RincianItem(
          label: 'Biaya Lainnya',
          nilai: part.replaceFirst('Lainnya:', '').trim(),
          icon: Icons.more_horiz_outlined,
        ));
      } else if (part.contains('/ orang')) {
        final cleanVal = part.replaceAll('(', '').replaceAll(')', '').trim();
        items.add(_RincianItem(
          label: 'Estimasi per Orang',
          nilai: cleanVal,
          icon: Icons.person_outline,
        ));
      }
    }

    return items;
  }

  String? _ekstrakCatatanKustom(String? catatan) {
    if (catatan == null || catatan.trim().isEmpty) return null;
    final parts =
        catatan.split('•').map((s) => s.trim()).where((s) => s.isNotEmpty);
    final nonCostParts = parts.where((p) =>
        !p.startsWith('Transport:') &&
        !p.startsWith('Penginapan:') &&
        !p.startsWith('Makan:') &&
        !p.startsWith('Tiket:') &&
        !p.startsWith('Lainnya:') &&
        !p.contains('/ orang')).toList();

    if (nonCostParts.isEmpty) return null;
    return nonCostParts.join('\n');
  }

  void tampilkanForm({Map<String, dynamic>? data}) {
    final tujuanController =
        TextEditingController(text: data?['tujuan']?.toString() ?? '');
    final tanggalController =
        TextEditingController(text: data?['tanggal']?.toString() ?? '');
    final orangController =
        TextEditingController(text: data?['orang']?.toString() ?? '');
    final budgetController =
        TextEditingController(text: data?['budget']?.toString() ?? '');
    final catatanController =
        TextEditingController(text: data?['catatan']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: Text(
            data == null ? 'Tambah Rencana' : 'Edit Rencana',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tujuanController,
                  decoration: const InputDecoration(
                    labelText: 'Tujuan Perjalanan',
                    prefixIcon:
                        Icon(Icons.place_outlined, color: AppColors.blue),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tanggalController,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Perjalanan',
                    prefixIcon: Icon(Icons.calendar_today_outlined,
                        color: AppColors.blue),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: orangController,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Orang',
                    prefixIcon:
                        Icon(Icons.people_outline, color: AppColors.blue),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: budgetController,
                  decoration: const InputDecoration(
                    labelText: 'Estimasi Budget',
                    prefixIcon: Icon(Icons.payments_outlined,
                        color: AppColors.blue),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: catatanController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Catatan / Rincian',
                    prefixIcon:
                        Icon(Icons.notes_outlined, color: AppColors.blue),
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
                final tujuan = tujuanController.text.trim();
                if (tujuan.isEmpty) {
                  return;
                }

                final rowData = {
                  'tujuan': tujuan,
                  'tanggal': tanggalController.text.trim().isEmpty
                      ? '-'
                      : tanggalController.text.trim(),
                  'orang': orangController.text.trim().isEmpty
                      ? '1 orang'
                      : orangController.text.trim(),
                  'budget': budgetController.text.trim().isEmpty
                      ? '-'
                      : budgetController.text.trim(),
                  'catatan': catatanController.text.trim(),
                };

                Navigator.of(dialogCtx).pop();

                try {
                  if (data == null) {
                    await ApiService.instance.tambahRencana(rowData);
                  } else {
                    final id = (data['id'] as num).toInt();
                    await ApiService.instance.updateRencana(id, rowData);
                  }
                } catch (_) {}

                try {
                  if (data == null) {
                    await DatabaseHelper.instance.tambahRencana(rowData);
                  } else {
                    final id = (data['id'] as num).toInt();
                    await DatabaseHelper.instance.updateRencana(id, rowData);
                  }
                } catch (_) {}

                await _muatRencana();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        data == null
                            ? 'Hasil komputasi berhasil disimpan!'
                            : 'Hasil komputasi berhasil diperbarui!',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Text(
                data == null ? 'Simpan' : 'Update',
              ),
            ),
          ],
        );
      },
    );
  }

  void hapusRencana(int id, String tujuan) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text(
          'Hapus Hasil Komputasi',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text('Yakin ingin menghapus rencana liburan ke "$tujuan"?'),
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
                await ApiService.instance.hapusRencana(id);
              } catch (_) {}
              try {
                await DatabaseHelper.instance.hapusRencana(id);
              } catch (_) {}

              await _muatRencana();

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rencana berhasil dihapus'),
                  ),
                );
              }
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 15,
              color: AppColors.blue,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textDark,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
                color: isBold ? AppColors.blue : AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan, int id) {
    final isExpanded = _expandedIds.contains(id);
    final rincianList = _ekstrakRincianBiaya(plan['catatan']?.toString());
    final catatanKustom = _ekstrakCatatanKustom(plan['catatan']?.toString());

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          setState(() {
            if (isExpanded) {
              _expandedIds.remove(id);
            } else {
              _expandedIds.add(id);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Tampak Luar (Ringkas)
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.blue.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.calculate_outlined,
                      color: AppColors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      plan['tujuan']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit Rencana',
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    color: AppColors.blue,
                    onPressed: () {
                      tampilkanForm(data: plan);
                    },
                  ),
                  IconButton(
                    tooltip: 'Hapus',
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: AppColors.textDark.withValues(alpha: 0.6),
                    onPressed: () {
                      hapusRencana(id, plan['tujuan']?.toString() ?? '');
                    },
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Chip ringkasan luar (menggunakan Wrap agar bebas RenderFlex overflow)
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 13,
                          color: AppColors.blue,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          plan['tanggal']?.toString() ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.people_outline,
                          size: 14,
                          color: AppColors.blue,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          plan['orang']?.toString() ?? '1 orang',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 14,
                          color: AppColors.blue,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          plan['budget']?.toString() ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Bagian Dalam: Rincian mendatar ke bawah saat dipencet
              if (isExpanded) ...[
                const Divider(height: 24),
                Row(
                  children: const [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 16,
                      color: AppColors.blue,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Rincian Biaya & Perjalanan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildDetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Tanggal Perjalanan',
                  value: plan['tanggal']?.toString() ?? '-',
                ),
                _buildDetailRow(
                  icon: Icons.people_outline,
                  label: 'Jumlah Orang',
                  value: plan['orang']?.toString() ?? '-',
                ),
                _buildDetailRow(
                  icon: Icons.payments_outlined,
                  label: 'Total Estimasi Anggaran',
                  value: plan['budget']?.toString() ?? '-',
                  isBold: true,
                ),
                if (rincianList.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: rincianList.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.5),
                          child: Row(
                            children: [
                              Icon(
                                item.icon,
                                size: 14,
                                color: AppColors.blue,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.label,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                              Text(
                                item.nilai,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
                if (catatanKustom != null &&
                    catatanKustom.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.notes_outlined,
                          size: 16,
                          color: AppColors.blue,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            catatanKustom,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hasil Komputasi Perjalanan',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh data',
            icon: const Icon(Icons.refresh),
            onPressed: _muatRencana,
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
                          color: AppColors.blue,
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
                          onPressed: _muatRencana,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  color: AppColors.blue,
                  onRefresh: _muatRencana,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        'Hasil Komputasi & Rencana Perjalanan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.blue,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Daftar estimasi biaya dan rencana perjalanan wisata yang telah dihitung.',
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
                              'Belum ada hasil komputasi perjalanan.\nMasuk ke menu Komputasi Perjalanan untuk menghitung dan menyimpan rencana liburanmu.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textDark,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ...List.generate(
                        plans.length,
                        (index) {
                          final plan = plans[index];
                          final id = (plan['id'] as num).toInt();
                          return _buildPlanCard(plan, id);
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