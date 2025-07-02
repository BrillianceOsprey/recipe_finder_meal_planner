import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../data/datasources/favorite_local_datasource.dart';
import '../../data/repositories/favorite_repository.dart';
import '../../../recipe_search/domain/models/recipe.dart';
import 'package:hive/hive.dart';

final favoriteBoxProvider = Provider<Box<Recipe>>((ref) {
  return Hive.box<Recipe>('favorite_recipes');
});

final favoriteLocalDatasourceProvider = Provider<FavoriteLocalDatasource>(
    (ref) => FavoriteLocalDatasource(ref.read(favoriteBoxProvider)));

final favoriteRepositoryProvider = Provider<FavoriteRepository>(
    (ref) => FavoriteRepositoryImpl(ref.read(favoriteLocalDatasourceProvider)));

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Recipe>>((ref) {
  return FavoritesNotifier(ref.read(favoriteRepositoryProvider));
});

class FavoritesNotifier extends StateNotifier<List<Recipe>> {
  final FavoriteRepository repository;

  FavoritesNotifier(this.repository) : super(repository.getFavoriteRecipes());

  void addFavorite(Recipe recipe) async {
    await repository.addFavorite(recipe);
    state = repository.getFavoriteRecipes();
  }

  void removeFavorite(int recipeId) async {
    await repository.removeFavorite(recipeId);
    state = repository.getFavoriteRecipes();
  }

  bool isFavorite(int recipeId) => state.any((recipe) => recipe.id == recipeId);
}
