import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_datasource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDatasource localDatasource;

  FavoriteRepositoryImpl(this.localDatasource);

  @override
  List<int> getFavoriteIds() => localDatasource.getFavoriteIds();

  @override
  bool isFavorite(int recipeId) => localDatasource.isFavorite(recipeId);

  @override
  Future<void> addFavorite(int recipeId) =>
      localDatasource.addFavorite(recipeId);

  @override
  Future<void> removeFavorite(int recipeId) =>
      localDatasource.removeFavorite(recipeId);
}
