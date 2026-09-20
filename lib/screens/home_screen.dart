import 'dart:ui';
import 'package:flutter/material.dart';
import '../tema/app_theme.dart';
import 'login_screen.dart';
import 'anggota_screen.dart';
import 'destinasi_screen.dart';
import 'travel_calculator_screen.dart';
import 'travel_plan_screen.dart';
import 'date_converter_screen.dart';
import 'nusantara_calendar_screen.dart';
import 'stopwatch_screen.dart';
import 'help_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

<<<<<<< HEAD
=======
  // =========================
  // MENU UTAMA KALANUSA
  // =========================
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
  final List<String> menuTitles = [
    'Daftar Anggota',
    'Destinasi Nusantara',
    'Komputasi Perjalanan',
    'Rencana Perjalanan',
    'Konversi & Waktu',
    'Kalender Nusantara',
  ];

  final List<String> menuDescriptions = [
    'Lihat anggota kelompok.',
    'Temukan dan simpan informasi destinasi wisata.',
    'Hitung budget dan kebutuhan perjalanan.',
    'Buat dan kelola rencana perjalanan.',
    'Kelola tanggal, waktu, dan durasi perjalanan.',
    'Jelajahi kalender dan budaya Nusantara.',
  ];

  final List<IconData> menuIcons = [
    Icons.groups_outlined,
    Icons.location_on_outlined,
    Icons.calculate_outlined,
    Icons.map_outlined,
    Icons.calendar_month_outlined,
    Icons.public_outlined,
  ];

<<<<<<< HEAD
  // Destinasi wisata unggulan untuk showcase di bawah KALANUSA
  final List<Map<String, String>> popularDestinations = [
    {
      'nama': 'Raja Ampat',
      'lokasi': 'Papua Barat Daya',
      'kategori': 'Wisata Bahari',
      'foto':
          'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=800',
      'badge': 'Terpopuler',
    },
    {
      'nama': 'Candi Borobudur',
      'lokasi': 'Magelang, Jawa Tengah',
      'kategori': 'Warisan Budaya',
      'foto':
          'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=800',
      'badge': 'UNESCO',
    },
    {
      'nama': 'Gunung Bromo',
      'lokasi': 'Jawa Timur',
      'kategori': 'Wisata Alam',
      'foto':
          'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272?w=800',
      'badge': 'Ikonik',
    },
    {
      'nama': 'Nusa Penida',
      'lokasi': 'Bali',
      'kategori': 'Wisata Pantai',
      'foto':
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
      'badge': 'Favorit',
    },
    {
      'nama': 'Labuan Bajo',
      'lokasi': 'Nusa Tenggara Timur',
      'kategori': 'Taman Nasional',
      'foto':
          'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=800',
      'badge': 'Eksotis',
    },
  ];

=======
  // =========================
  // LOGOUT
  // =========================
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  void bukaMenu(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AnggotaScreen(),
        ),
      );
<<<<<<< HEAD
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DestinasiScreen(),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TravelCalculatorScreen(),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TravelPlanScreen(),
        ),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DateConverterScreen(),
        ),
      );
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NusantaraCalendarScreen(),
        ),
      );
    }
  }

  Widget buildFeatureCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.blue.withValues(alpha: 0.12),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBlue.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            bukaMenu(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Wadah ikon dengan warna biru lembut yang serasi
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.blue.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    menuIcons[index],
                    color: AppColors.blue,
                    size: 27,
                  ),
                ),

                const SizedBox(width: 15),

                // Teks judul dan deskripsi fitur
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menuTitles[index],
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        menuDescriptions[index],
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: AppColors.textDark.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Tombol aksi panah bundar elegan yang senada
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.blue.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.blue,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget kartu destinasi tempat wisata di bawah KALANUSA
  Widget buildDestinationItem(Map<String, String> item) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              bukaMenu(1); // Buka layar destinasi
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Gambar tempat wisata
                Image.network(
                  item['foto']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blue,
                            AppColors.darkBlue,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.landscape_rounded,
                          color: Colors.white54,
                          size: 38,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColors.blue.withValues(alpha: 0.1),
                      child: const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColors.blue),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Gradien transparan elegan di atas gambar
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.15),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),

                // Badge kategori transparan di sudut atas
                Positioned(
                  top: 10,
                  left: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          item['badge'] ?? '',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Informasi tempat wisata di bawah kartu
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item['nama'] ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 13,
                            color: AppColors.cream,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              item['lokasi'] ?? '',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

=======
      return;
    }

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DestinasiScreen(),
        ),
      );
      return;
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TravelCalculatorScreen(),
        ),
      );
      return;
    }

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TravelPlanScreen(),
        ),
      );
      return;
    }

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DateConverterScreen(),
        ),
      );
      return;
    }

    if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NusantaraCalendarScreen(),
        ),
      );
      return;
    }
  }

  // =========================
  // HALAMAN UTAMA
  // =========================
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
  Widget buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            // HEADER HERO KALANUSA DENGAN GAMBAR & EFEK TRANSPARAN ELEGAN
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkBlue.withValues(alpha: 0.22),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  children: [
                    // Gambar latar belakang tempat wisata
                    Positioned.fill(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=800',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.blue,
                        ),
                      ),
                    ),

                    // Lapisan gradien transparan elegan
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.darkBlue.withValues(alpha: 0.88),
                              AppColors.blue.withValues(alpha: 0.72),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),

                    // Konten di dalam header KALANUSA
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tagline transparan di atas
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white
                                            .withValues(alpha: 0.3),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.explore_rounded,
                                          color: Colors.white,
                                          size: 13,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'TRAVEL PLANNER',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.flight_takeoff_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // TULISAN KALANUSA
                          const Text(
                            'KALANUSA',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.4,
                              shadows: [
                                Shadow(
                                  color: Colors.black38,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            'Jelajahi Pesona Keindahan Nusantara',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 14),

                          // KOTAK TRANSPARAN ELEGAN DI BAWAH TULISAN KALANUSA
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.16),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color:
                                        Colors.white.withValues(alpha: 0.28),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(alpha: 0.22),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.place_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        'Rencanakan petualangan wisatamu di tanah air',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // BAGIAN GAMBAR TEMPAT WISATA DI BAWAH TULISAN KALANUSA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.map_rounded,
                      color: AppColors.blue,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Destinasi Populer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => bukaMenu(1),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lihat Semua',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: AppColors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // LIST HORIZONTAL GAMBAR TEMPAT WISATA BERGAYA TRAVEL
            SizedBox(
              height: 155,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularDestinations.length,
                itemBuilder: (context, index) {
                  return buildDestinationItem(popularDestinations[index]);
                },
              ),
            ),

            const SizedBox(height: 26),

            // JUDUL MENU UTAMA
=======
            // =========================
            // HEADER / HERO
            // =========================
        Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(
    horizontal: 28,
    vertical: 10,
  ),
  decoration: BoxDecoration(
    color: AppColors.cream,
    borderRadius: BorderRadius.circular(24),
  ),
  child: Row(
    children: [
      Expanded(
        flex: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'KALANUSA',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: AppColors.blue,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
            const Text(
              'Menu Utama',
              style: TextStyle(
<<<<<<< HEAD
                fontSize: 21,
                fontWeight: FontWeight.w800,
=======
                fontSize: 16,
                fontWeight: FontWeight.w700,
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
<<<<<<< HEAD
              'Pilih fitur yang ingin kamu gunakan.',
=======
              'Rencanakan perjalananmu,\njelajahi Nusantara.',
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textDark,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(width: 10),

      Expanded(
        flex: 6,
        child: Image.asset(
          'assets/images/KALANUSA.png',
          height: 190,
          fit: BoxFit.contain,
        ),
      ),
    ],
  ),
),

<<<<<<< HEAD
            const SizedBox(height: 16),

            // DAFTAR MENU UTAMA
            ...List.generate(
              menuTitles.length,
              (index) {
                return buildFeatureCard(index);
=======
            const SizedBox(height: 28),

            // =========================
            // JUDUL MENU
            // =========================
            const Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 14),

            // =========================
            // DAFTAR MENU
            // =========================
            ...List.generate(
              menuTitles.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        bukaMenu(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            // =========================
                            // ICON
                            // =========================
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.offWhite,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                menuIcons[index],
                                color: AppColors.blue,
                                size: 26,
                              ),
                            ),

                            const SizedBox(width: 15),

                            // =========================
                            // TEXT
                            // =========================
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menuTitles[index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    menuDescriptions[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textDark.withOpacity(
                                        0.75,
                                      ),
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // =========================
                            // ARROW
                            // =========================
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.blue,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
              },
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
=======
  // =========================
  // STOPWATCH
  // =========================
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
  Widget buildStopwatchPage() {
    return const StopwatchScreen();
  }

  Widget buildHelpPage() {
<<<<<<< HEAD
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bantuan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'KALANUSA membantu kamu merencanakan perjalanan '
              'dan mengenal berbagai informasi Nusantara.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 25),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: AppColors.blue,
                ),
                title: const Text(
                  'Tentang KALANUSA',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: const Text(
                  'Travel Planner Nusantara',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.blue,
                ),
                title: const Text(
                  'Keluar',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: const Text(
                  'Keluar dari halaman utama',
                ),
                onTap: logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
=======
  return const HelpScreen();
}
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c

  // NAVBAR ALA APLIKASI TRAVEL: TRANSPARAN & ELEGAN
  Widget buildTravelNavBar() {
    final navItems = [
      {
        'label': 'Utama',
        'activeIcon': Icons.explore_rounded,
        'inactiveIcon': Icons.explore_outlined,
      },
      {
        'label': 'Stopwatch',
        'activeIcon': Icons.timer_rounded,
        'inactiveIcon': Icons.timer_outlined,
      },
      {
        'label': 'Bantuan',
        'activeIcon': Icons.help_rounded,
        'inactiveIcon': Icons.help_outline_rounded,
      },
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.88),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.7),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (index) {
                final isSelected = selectedIndex == index;
                final item = navItems[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 18 : 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppColors.blue, AppColors.darkBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isSelected ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.blue.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          (isSelected
                              ? item['activeIcon']
                              : item['inactiveIcon']) as IconData,
                          size: 22,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textDark.withValues(alpha: 0.65),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Text(
                            item['label'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildHomePage(),
      buildStopwatchPage(),
      buildHelpPage(),
    ];

    return Scaffold(
<<<<<<< HEAD
      extendBody: true, // Memungkinkan efek transparan navbar yang elegan
=======
      // =========================
      // APP BAR
      // =========================
>>>>>>> 62fd8520bfa7a1f5c064d9928b6925ae91f1226c
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          selectedIndex == 0
              ? 'Halaman Utama'
              : selectedIndex == 1
                  ? 'Stopwatch'
                  : 'Bantuan',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: buildTravelNavBar(),
    );
  }
}