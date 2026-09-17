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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // =========================
  // 5 MENU UTAMA KALANUSA
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
            // HEADER
            // =========================
            const Text(
              'KALANUSA',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: AppColors.blue,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Travel Planner Nusantara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Rencanakan perjalananmu, jelajahi Nusantara.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // MENU UTAMA
            // =========================
            const Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 15),

            ...List.generate(
              menuTitles.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        bukaMenu(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 17,
                        ),
                        child: Row(
                          children: [
                            // ICON
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: AppColors.offWhite,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                menuIcons[index],
                                color: AppColors.blue,
                                size: 28,
                              ),
                            ),

                            const SizedBox(width: 16),

                            // TEXT
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

                                  const SizedBox(height: 4),

                                  Text(
                                    menuDescriptions[index],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // ARROW
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.blue,
                              size: 26,
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
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? 'Halaman Utama'
              : selectedIndex == 1
                  ? 'Stopwatch'
                  : 'Bantuan',
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