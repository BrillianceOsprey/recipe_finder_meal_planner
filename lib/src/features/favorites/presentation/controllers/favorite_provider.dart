import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../data/datasources/favorite_local_datasource.dart';
import '../../domain/repositories/favorite_repository.dart';
import 'package:hive/hive.dart';

final favoriteBoxProvider = Provider<Box<int>>((ref) => Hive.box<int>('favorite_recipes'));
final favoriteLocalDatasourceProvider = Provider<FavoriteLocalDatasource>(
    (ref) => FavoriteLocalDatasource(ref.read(favoriteBoxProvider)));
final favoriteRepositoryProvider = Provider<FavoriteRepository>(
    (ref) => FavoriteRepositoryImpl(ref.read(favoriteLocalDatasourceProvider)));

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier(ref.read(favoriteRepositoryProvider));
});

class FavoritesNotifier extends StateNotifier<List<int>> {
  final FavoriteRepository repository;

  FavoritesNotifier(this.repository) : super(repository.getFavoriteIds());

  void addFavorite(int recipeId) async {
    await repository.addFavorite(recipeId);
    state = repository.getFavoriteIds();
  }

  void removeFavorite(int recipeId) async {
    await repository.removeFavorite(recipeId);
    state = repository.getFavoriteIds();
  }

  bool isFavorite(int recipeId) => state.contains(recipeId);
}
