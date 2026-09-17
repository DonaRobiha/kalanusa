import 'package:flutter/material.dart';
import 'tema/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const KalanusaApp());
}

class KalanusaApp extends StatelessWidget {
  const KalanusaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KALANUSA',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}