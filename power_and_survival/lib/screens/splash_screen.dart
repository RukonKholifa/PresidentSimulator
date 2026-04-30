import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.mainMenu);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.accent, width: 3),
                ),
                child: const Icon(Icons.account_balance, size: 40, color: AppTheme.accent),
              ),
              const SizedBox(height: 20),
              Text('Power & Survival', style: AppTheme.headerStyle(size: 28)),
              Text('President Simulator', style: AppTheme.bodyStyle(size: 14, color: AppTheme.textSecondary)),
              const SizedBox(height: 24),
              Text(StringsEn.createdBy, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
