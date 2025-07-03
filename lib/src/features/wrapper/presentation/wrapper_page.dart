import 'package:flutter/material.dart';
import '../../favorites/presentation/pages/favorites_page.dart';
import '../../meal_planner/presentation/pages/meal_planner_page.dart';
import '../../recipe_search/presentation/pages/recipe_search_page.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _currentIndex = 0;

  final _pages = const [
    RecipeSearchPage(),
    FavoritesPage(),
    MealPlannerPage(),
  ];

  final List<Widget> _icons = const [
    Icon(Icons.search, size: 30),
    Icon(Icons.favorite, size: 30),
    Icon(Icons.calendar_month, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AnimatedBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _icons,
      ),
    );
  }
}

class AnimatedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<Widget> items;

  const AnimatedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      elevation: 10.0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFFFF6B6B),
      unselectedItemColor: Colors.grey,
      selectedFontSize: 14.0,
      unselectedFontSize: 12.0,
      items: List.generate(items.length, (index) {
        return BottomNavigationBarItem(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              // Removed 'const' from the tween initialization
              final tween = Tween(begin: 0.8, end: 1.0);
              var scaleAnimation = animation.drive(tween);
              return ScaleTransition(scale: scaleAnimation, child: child);
            },
            child: currentIndex == index
                ? IconTheme(
                    data: IconThemeData(color: Color(0xFFFF6B6B)),
                    child: items[index],
                  )
                : IconTheme(
                    data: IconThemeData(color: Colors.grey),
                    child: items[index],
                  ),
          ),
          label: index == 0
              ? 'Search'
              : index == 1
                  ? 'Favorites'
                  : 'Meal Plan',
        );
      }),
    );
  }
}
