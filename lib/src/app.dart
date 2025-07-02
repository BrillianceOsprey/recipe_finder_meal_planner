import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/favorites/presentation/pages/favorites_page.dart';
import 'features/meal_planner/presentation/pages/meal_planner_page.dart';
import 'features/recipe_search/presentation/pages/recipe_search_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final _pages = const [
    RecipeSearchPage(),
    FavoritesPage(),
    MealPlannerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Recipe Finder & Meal Planner',
        theme: ThemeData(primarySwatch: Colors.green),
        home: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Meal Plan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
