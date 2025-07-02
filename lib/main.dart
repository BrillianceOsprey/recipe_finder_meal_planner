import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_finder_meal_planner/src/features/recipe_search/domain/models/recipe.dart';
import 'src/app.dart';
import 'src/features/meal_planner/domain/models/meal_plan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MealPlanAdapter());
  Hive.registerAdapter(RecipeAdapter());
  await Hive.openBox<Recipe>('favorite_recipes');
  await Hive.openBox<MealPlan>('main');
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
