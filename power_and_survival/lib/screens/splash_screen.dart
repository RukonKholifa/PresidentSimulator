import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.mainMenu);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance, size: 80, color: AppTheme.gold)
                .animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.5, 0.5)),
            const SizedBox(height: 24),
            Text(
              StringsEn.appTitle,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.gold),
            ).animate().fadeIn(delay: 500.ms, duration: 800.ms),
            const SizedBox(height: 8),
            Text(
              StringsEn.appSubtitle,
              style: const TextStyle(fontSize: 16, color: AppTheme.textSecondary),
            ).animate().fadeIn(delay: 800.ms, duration: 800.ms),
            const SizedBox(height: 48),
            const CircularProgressIndicator(color: AppTheme.accent)
                .animate().fadeIn(delay: 1000.ms),
          ],
        ),
      ),
    );
  }
}
