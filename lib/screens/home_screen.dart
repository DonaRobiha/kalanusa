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

  // =========================
  // MENU UTAMA KALANUSA
  // =========================
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

  // =========================
  // LOGOUT
  // =========================
  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  // =========================
  // AKSI MENU
  // =========================
  void bukaMenu(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AnggotaScreen(),
        ),
      );
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
  Widget buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const Text(
              'Travel Planner Nusantara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Rencanakan perjalananmu,\njelajahi Nusantara.',
              style: TextStyle(
                fontSize: 14,
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
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // STOPWATCH
  // =========================
  Widget buildStopwatchPage() {
    return const StopwatchScreen();
  }

  // =========================
  // BANTUAN
  // =========================
  Widget buildHelpPage() {
  return const HelpScreen();
}

  // =========================
  // BUILD
  // =========================
  @override
  Widget build(BuildContext context) {
    final pages = [
      buildHomePage(),
      buildStopwatchPage(),
      buildHelpPage(),
    ];

    return Scaffold(
      // =========================
      // APP BAR
      // =========================
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

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Utama',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Stopwatch',
          ),
          NavigationDestination(
            icon: Icon(Icons.help_outline),
            selectedIcon: Icon(Icons.help),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}