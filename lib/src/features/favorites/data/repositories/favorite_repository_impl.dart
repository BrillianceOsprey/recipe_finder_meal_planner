import 'favorite_repository.dart';
import '../datasources/favorite_local_datasource.dart';
import '../../../recipe_search/domain/models/recipe.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDatasource localDatasource;

  FavoriteRepositoryImpl(this.localDatasource);

  @override
  List<Recipe> getFavoriteRecipes() {
    return localDatasource.getFavoriteRecipes();
  }

  @override
  bool isFavorite(int recipeId) {
    return localDatasource.isFavorite(recipeId);
  }

  @override
  Future<void> addFavorite(Recipe recipe) async {
    await localDatasource.addFavorite(recipe);
  }

  @override
  Future<void> removeFavorite(int recipeId) async {
    await localDatasource.removeFavorite(recipeId);
  }
}
