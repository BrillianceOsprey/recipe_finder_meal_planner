import '../../../recipe_search/domain/models/recipe.dart';

abstract class FavoriteRepository {
  List<Recipe> getFavoriteRecipes();
  bool isFavorite(int recipeId);
  Future<void> addFavorite(Recipe recipe);
  Future<void> removeFavorite(int recipeId);
}
