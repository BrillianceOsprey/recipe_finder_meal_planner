import 'package:hive/hive.dart';
import '../../domain/models/meal_plan.dart';

class MealPlanLocalDatasource {
  static const String boxName = 'meal_plan';

  Future<Box<MealPlan>> _openBox() async {
    return await Hive.openBox<MealPlan>(boxName);
  }

  Future<MealPlan> loadMealPlan() async {
    final box = await _openBox();
    if (box.isEmpty) {
      final empty = MealPlan.empty();
      await box.put('main', empty);
      return empty;
    }
    return box.get('main')!;
  }

  Future<void> saveMealPlan(MealPlan mealPlan) async {
    final box = await _openBox();
    await box.put('main', mealPlan);
  }
}
