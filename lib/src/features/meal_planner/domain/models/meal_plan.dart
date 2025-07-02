import 'package:hive/hive.dart';

part 'meal_plan.g.dart';

@HiveType(typeId: 1)
class MealPlan extends HiveObject {
  @HiveField(0)
  Map<String, List<int>> days; // 'Monday': [recipeId1, recipeId2], etc.

  MealPlan({required this.days});

  factory MealPlan.empty() {
    return MealPlan(days: {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    });
  }
}
