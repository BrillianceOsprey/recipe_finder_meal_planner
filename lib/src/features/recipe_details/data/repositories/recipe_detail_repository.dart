import '../../domain/models/recipe_detail.dart';

abstract class RecipeDetailRepository {
  Future<RecipeDetail> getRecipeDetail(int id);
}
