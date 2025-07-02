import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail.freezed.dart';
part 'recipe_detail.g.dart';

@freezed
sealed class RecipeDetail with _$RecipeDetail {
  const factory RecipeDetail({
    required int id,
    required String title,
    String? image,
    int? readyInMinutes,
    int? servings,
    String? summary,
    String? instructions,
    List<ExtendedIngredient>? extendedIngredients,
    List<AnalyzedInstruction>? analyzedInstructions,
    Nutrition? nutrition,
  }) = _RecipeDetail;

  factory RecipeDetail.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailFromJson(json);
}

@freezed
sealed class ExtendedIngredient with _$ExtendedIngredient {
  const factory ExtendedIngredient({
    required int id,
    required String name,
    required String original,
    String? image,
    double? amount,
    String? unit,
  }) = _ExtendedIngredient;

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      _$ExtendedIngredientFromJson(json);
}

@freezed
sealed class AnalyzedInstruction with _$AnalyzedInstruction {
  const factory AnalyzedInstruction({
    required List<InstructionStep> steps,
  }) = _AnalyzedInstruction;

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedInstructionFromJson(json);
}

@freezed
sealed class InstructionStep with _$InstructionStep {
  const factory InstructionStep({
    required int number,
    required String step,
  }) = _InstructionStep;

  factory InstructionStep.fromJson(Map<String, dynamic> json) =>
      _$InstructionStepFromJson(json);
}

@freezed
sealed class Nutrition with _$Nutrition {
  const factory Nutrition({
    @Default([]) List<Nutrient> nutrients,
  }) = _Nutrition;

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);
}

@freezed
sealed class Nutrient with _$Nutrient {
  const factory Nutrient({
    required String name,
    required double amount,
    required String unit,
  }) = _Nutrient;

  factory Nutrient.fromJson(Map<String, dynamic> json) =>
      _$NutrientFromJson(json);
}
