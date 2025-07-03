import 'package:flutter/material.dart';
import 'package:recipe_finder_meal_planner/src/features/wrapper/presentation/wrapper_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../onboarding/presentation/pages/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool("isFirstLaunch") ?? true;

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return; // Check if widget is still in the tree

    if (isFirstLaunch) {
      prefs.setBool("isFirstLaunch", false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WrapperPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo/meal_match.png'), // Splash logo image
      ),
    );
  }
}
