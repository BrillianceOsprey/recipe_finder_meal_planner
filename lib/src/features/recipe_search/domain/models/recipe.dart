import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
@HiveType(typeId: 0) // Ensure that typeId is unique and properly defined
sealed class Recipe with _$Recipe {
  const factory Recipe({
    @HiveField(0) required int id,
    @HiveField(1) required String title,
    @HiveField(2) String? image,
    @HiveField(3) String? imageType,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
