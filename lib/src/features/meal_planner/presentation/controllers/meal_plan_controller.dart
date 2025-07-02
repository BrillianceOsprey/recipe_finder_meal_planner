import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/meal_plan_repository.dart';
import '../../domain/models/meal_plan.dart';

class MealPlanState {
  final MealPlan mealPlan;
  final bool loading;
  final String? error;
  MealPlanState({required this.mealPlan, this.loading = false, this.error});
  MealPlanState copyWith({MealPlan? mealPlan, bool? loading, String? error}) =>
      MealPlanState(
        mealPlan: mealPlan ?? this.mealPlan,
        loading: loading ?? this.loading,
        error: error,
      );
}

class MealPlanController extends StateNotifier<MealPlanState> {
  final MealPlanRepository repository;
  MealPlanController(this.repository)
      : super(MealPlanState(mealPlan: MealPlan.empty()));

  Future<void> load() async {
    state = state.copyWith(loading: true, error: null);
    try {
      final mealPlan = await repository.loadMealPlan();
      state = state.copyWith(mealPlan: mealPlan, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addRecipe(String day, int recipeId) async {
    final days = Map<String, List<int>>.from(state.mealPlan.days);
    if (!days[day]!.contains(recipeId)) {
      days[day] = [...days[day]!, recipeId];
      final updated = MealPlan(days: days);
      await repository.saveMealPlan(updated);
      state = state.copyWith(mealPlan: updated);
    }
  }

  Future<void> removeRecipe(String day, int recipeId) async {
    final days = Map<String, List<int>>.from(state.mealPlan.days);
    days[day] = days[day]!..remove(recipeId);
    final updated = MealPlan(days: days);
    await repository.saveMealPlan(updated);
    state = state.copyWith(mealPlan: updated);
  }

  Future<void> clearDay(String day) async {
    final days = Map<String, List<int>>.from(state.mealPlan.days);
    days[day] = [];
    final updated = MealPlan(days: days);
    await repository.saveMealPlan(updated);
    state = state.copyWith(mealPlan: updated);
  }

  Future<void> clearAll() async {
    final cleared = MealPlan.empty();
    await repository.saveMealPlan(cleared);
    state = state.copyWith(mealPlan: cleared);
  }
}
