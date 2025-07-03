import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder_meal_planner/src/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:recipe_finder_meal_planner/src/features/splash/presentation/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SplashScreen', () {
    testWidgets('shows logo and navigates to OnboardingScreen on first launch',
        (tester) async {
      // Arrange
      SharedPreferences.setMockInitialValues(
          {}); // no isFirstLaunch key, so first launch

      await tester.pumpWidget(
        const MaterialApp(
          home: SplashScreen(),
        ),
      );

      // Assert logo is displayed
      expect(find.byType(Image), findsOneWidget);

      // simulate 2 second delay
      await tester.pump(const Duration(seconds: 2));

      // simulate Navigator pushReplacement
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsOneWidget);
    });
  });
}
