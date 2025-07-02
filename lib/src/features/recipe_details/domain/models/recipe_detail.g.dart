// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeDetail _$RecipeDetailFromJson(Map<String, dynamic> json) =>
    _RecipeDetail(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String?,
      readyInMinutes: (json['readyInMinutes'] as num?)?.toInt(),
      servings: (json['servings'] as num?)?.toInt(),
      summary: json['summary'] as String?,
      instructions: json['instructions'] as String?,
      extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
          ?.map((e) => ExtendedIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      analyzedInstructions: (json['analyzedInstructions'] as List<dynamic>?)
          ?.map((e) => AnalyzedInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      nutrition: json['nutrition'] == null
          ? null
          : Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeDetailToJson(_RecipeDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
      'summary': instance.summary,
      'instructions': instance.instructions,
      'extendedIngredients': instance.extendedIngredients,
      'analyzedInstructions': instance.analyzedInstructions,
      'nutrition': instance.nutrition,
    };

_ExtendedIngredient _$ExtendedIngredientFromJson(Map<String, dynamic> json) =>
    _ExtendedIngredient(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      original: json['original'] as String,
      image: json['image'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$ExtendedIngredientToJson(_ExtendedIngredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original': instance.original,
      'image': instance.image,
      'amount': instance.amount,
      'unit': instance.unit,
    };

_AnalyzedInstruction _$AnalyzedInstructionFromJson(Map<String, dynamic> json) =>
    _AnalyzedInstruction(
      steps: (json['steps'] as List<dynamic>)
          .map((e) => InstructionStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyzedInstructionToJson(
        _AnalyzedInstruction instance) =>
    <String, dynamic>{
      'steps': instance.steps,
    };

_InstructionStep _$InstructionStepFromJson(Map<String, dynamic> json) =>
    _InstructionStep(
      number: (json['number'] as num).toInt(),
      step: json['step'] as String,
    );

Map<String, dynamic> _$InstructionStepToJson(_InstructionStep instance) =>
    <String, dynamic>{
      'number': instance.number,
      'step': instance.step,
    };

_Nutrition _$NutritionFromJson(Map<String, dynamic> json) => _Nutrition(
      nutrients: (json['nutrients'] as List<dynamic>?)
              ?.map((e) => Nutrient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NutritionToJson(_Nutrition instance) =>
    <String, dynamic>{
      'nutrients': instance.nutrients,
    };

_Nutrient _$NutrientFromJson(Map<String, dynamic> json) => _Nutrient(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$NutrientToJson(_Nutrient instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unit': instance.unit,
    };
