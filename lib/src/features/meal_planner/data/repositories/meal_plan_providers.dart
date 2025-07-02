import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/meal_plan_local_datasource.dart';
import 'meal_plan_repository.dart';
import 'meal_plan_repository_impl.dart';

final mealPlanLocalDatasourceProvider =
    Provider((ref) => MealPlanLocalDatasource());

final mealPlanRepositoryProvider = Provider<MealPlanRepository>((ref) {
  return MealPlanRepositoryImpl(ref.read(mealPlanLocalDatasourceProvider));
});
