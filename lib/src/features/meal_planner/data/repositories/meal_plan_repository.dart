import '../../domain/models/meal_plan.dart';

abstract class MealPlanRepository {
  Future<MealPlan> loadMealPlan();
  Future<void> saveMealPlan(MealPlan mealPlan);
}
