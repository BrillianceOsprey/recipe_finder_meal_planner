import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
sealed class Recipe with _$Recipe {
  const factory Recipe({
    required int id,
    required String title,
    String? image,
    String? imageType, // Fixed typo: was 'imgeType'
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
