abstract class FavoriteRepository {
  List<int> getFavoriteIds();
  bool isFavorite(int recipeId);
  Future<void> addFavorite(int recipeId);
  Future<void> removeFavorite(int recipeId);
}
