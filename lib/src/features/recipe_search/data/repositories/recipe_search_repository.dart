import '../../domain/models/recipe.dart';

abstract class RecipeSearchRepository {
  Future<List<Recipe>> searchRecipes(
    List<String> ingredients, {
    int offset = 0,
    int number = 10,
  });
  Future<List<Recipe>> getRecipesByIds(List<int> ids);
}
