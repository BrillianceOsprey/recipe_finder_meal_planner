import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/meal_plan_providers.dart';
import 'meal_plan_controller.dart';

final mealPlanControllerProvider =
    StateNotifierProvider<MealPlanController, MealPlanState>((ref) {
  return MealPlanController(ref.read(mealPlanRepositoryProvider));
});
