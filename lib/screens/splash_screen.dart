import 'dart:async';
import 'package:flutter/material.dart';
import '../tema/app_theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cream,
                  border: Border.all(
                    color: AppColors.blue,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.landscape_rounded,
                  size: 75,
                  color: AppColors.blue,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'KALANUSA',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  color: AppColors.blue,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Kalender dan Waktu',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 40),

              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}