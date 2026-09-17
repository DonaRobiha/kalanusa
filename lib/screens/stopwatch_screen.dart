import 'dart:async';
import 'package:flutter/material.dart';
import '../tema/app_theme.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  String formatWaktu() {
    final durasi = stopwatch.elapsed;

    final jam = durasi.inHours.toString().padLeft(2, '0');
    final menit = (durasi.inMinutes % 60).toString().padLeft(2, '0');
    final detik = (durasi.inSeconds % 60).toString().padLeft(2, '0');
    final milidetik =
        ((durasi.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0');

    return '$jam:$menit:$detik.$milidetik';
  }

  void mulai() {
    stopwatch.start();

    timer ??= Timer.periodic(
      const Duration(milliseconds: 30),
      (_) {
        setState(() {});
      },
    );
  }

  void berhenti() {
    stopwatch.stop();
    setState(() {});
  }

  void reset() {
    stopwatch.reset();
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 80,
                color: AppColors.blue,
              ),
              const SizedBox(height: 30),
              Text(
                formatWaktu(),
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: stopwatch.isRunning ? berhenti : mulai,
                    icon: Icon(
                      stopwatch.isRunning
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    label: Text(
                      stopwatch.isRunning ? 'Berhenti' : 'Mulai',
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}