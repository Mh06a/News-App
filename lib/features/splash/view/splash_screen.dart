import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/storage_key.dart';
import 'package:news_app/features/auth/view/login_screen.dart';
import 'package:news_app/features/onboarding/view/onboarding_screen.dart';
import 'package:news_app/features/user/repository/user_repository.dart';
import 'package:news_app/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));

    final bool onboardingComplete =
        PreferencesManager().getBool(StorageKey.onboardingComplete) ?? false;

    final bool isLoggedIn = await UserRepository().checkLogin();

    if (!mounted) return;

    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/splashImage.png",
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
