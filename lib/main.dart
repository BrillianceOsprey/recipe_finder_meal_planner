import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/app.dart';
import 'src/features/meal_planner/domain/models/meal_plan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('favorite_recipes');
  Hive.registerAdapter(MealPlanAdapter());
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
