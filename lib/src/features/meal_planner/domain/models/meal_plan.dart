import 'package:hive/hive.dart';

part 'meal_plan.g.dart';

@HiveType(typeId: 1)
class MealPlan extends HiveObject {
  @HiveField(0)
  Map<String, List<int>> recipesByday; // Store Recipe IDs

  MealPlan({required this.recipesByday});

  factory MealPlan.empty() {
    return MealPlan(recipesByday: {
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
