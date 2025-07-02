import '../../domain/models/meal_plan.dart';
import '../datasources/meal_plan_local_datasource.dart';
import 'meal_plan_repository.dart';

class MealPlanRepositoryImpl implements MealPlanRepository {
  final MealPlanLocalDatasource localDatasource;

  MealPlanRepositoryImpl(this.localDatasource);

  @override
  Future<MealPlan> loadMealPlan() => localDatasource.loadMealPlan();

  @override
  Future<void> saveMealPlan(MealPlan mealPlan) =>
      localDatasource.saveMealPlan(mealPlan);
}
