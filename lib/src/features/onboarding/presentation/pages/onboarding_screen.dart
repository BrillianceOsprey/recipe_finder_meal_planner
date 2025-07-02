// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:recipe_finder_meal_planner/src/app.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<PageViewModel> pages = [
//       PageViewModel(
//         title: "Welcome to Meal Planner",
//         body: "Find, plan, and enjoy your meals all week.",
//         image: _buildImage('assets/images/meal_planner.png'),
//         decoration: const PageDecoration(
//           pageColor: Colors.teal,
//         ),
//       ),
//       PageViewModel(
//         title: "Save Your Favorite Recipes",
//         body: "Save and organize your meals with ease.",
//         image: _buildImage('assets/images/favorites.png'),
//         decoration: const PageDecoration(
//           pageColor: Colors.blueAccent,
//         ),
//       ),
//       PageViewModel(
//         title: "Create a Weekly Meal Plan",
//         body: "Plan meals for the week and stay on track.",
//         image: _buildImage('assets/images/weekly_plan.png'),
//         decoration: const PageDecoration(
//           pageColor: Colors.orangeAccent,
//         ),
//       ),
//     ];

//     return IntroductionScreen(
//       pages: pages,
//       onDone: () => _onDonePress(context),
//       onSkip: () => _onSkipPress(context),
//       showSkipButton: true,
//       skip: const Text('Skip'),
//       next: const Text('Next'),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       dotsDecorator: DotsDecorator(
//         color: Colors.grey,
//         activeColor: Colors.teal,
//         size: Size(10.0, 10.0),
//         activeSize: Size(22.0, 10.0),
//         spacing: EdgeInsets.symmetric(horizontal: 3.0),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5.0))),
//       ),
//     );
//   }

//   // Function for image widget
//   Widget _buildImage(String path) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Image.asset(
//         path,
//         height: 300.0,
//         width: 300.0,
//         fit: BoxFit.contain,
//       ),
//     );
//   }

//   _onDonePress(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("isFirstLaunch", false);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const App()), // Home screen
//     );
//   }

//   _onSkipPress(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("isFirstLaunch", false);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const App()), // Home screen
//     );
//   }
// }
