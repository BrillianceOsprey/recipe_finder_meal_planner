import 'package:hive/hive.dart';

class FavoriteLocalDatasource {
  static const boxName = 'favorite_recipes';
  final Box<int> _box;

  FavoriteLocalDatasource(this._box);

  List<int> getFavoriteIds() => _box.values.toList();

  bool isFavorite(int recipeId) => _box.values.contains(recipeId);

  Future<void> addFavorite(int recipeId) async {
    if (!isFavorite(recipeId)) {
      await _box.add(recipeId);
    }
  }

  Future<void> removeFavorite(int recipeId) async {
    final key = _box.keys.firstWhere((k) => _box.get(k) == recipeId, orElse: () => null);
    if (key != null) {
      await _box.delete(key);
    }
  }
}
