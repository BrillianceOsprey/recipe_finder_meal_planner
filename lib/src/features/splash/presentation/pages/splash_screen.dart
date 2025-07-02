// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../app.dart';
// import '../../../onboarding/presentation/pages/onboarding_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkFirstLaunch();
//   }

//   _checkFirstLaunch() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstLaunch = prefs.getBool("isFirstLaunch") ?? true;

//     Future.delayed(const Duration(seconds: 3), () {
//       if (isFirstLaunch) {
//         // Mark first launch as done
//         prefs.setBool("isFirstLaunch", false);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (_) =>
//                   const OnboardingScreen()), // Navigate to onboarding screen
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (_) => const App()), // Navigate to the main app screen
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child:
//             Image.asset('assets/images/splash_logo.png'), // Splash logo image
//       ),
//     );
//   }
// }
