import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder_meal_planner/src/features/splash/presentation/pages/splash_screen.dart';
import 'features/favorites/presentation/pages/favorites_page.dart';
import 'features/meal_planner/presentation/pages/meal_planner_page.dart';
import 'features/recipe_search/presentation/pages/recipe_search_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final int _currentIndex = 0;

  final _pages = const [
    RecipeSearchPage(),
    FavoritesPage(),
    MealPlannerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipe Finder & Meal Planner',
        theme: ThemeData(primarySwatch: Colors.green),
        home: SplashScreen(),
      ),
    );
  }
}
