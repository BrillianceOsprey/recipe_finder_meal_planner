import 'package:hive/hive.dart';
import '../../../recipe_search/domain/models/recipe.dart';

class FavoriteLocalDatasource {
  static const boxName = 'favorite_recipes';
  final Box<Recipe> _box;

  FavoriteLocalDatasource(this._box);

  List<Recipe> getFavoriteRecipes() => _box.values.toList();

  bool isFavorite(int recipeId) {
    return _box.values.any((recipe) => recipe.id == recipeId);
  }

  Future<void> addFavorite(Recipe recipe) async {
    if (!isFavorite(recipe.id)) {
      await _box.add(recipe);
    }
  }

  Future<void> removeFavorite(int recipeId) async {
    final key = _box.keys
        .firstWhere((k) => _box.get(k)?.id == recipeId, orElse: () => null);
    if (key != null) {
      await _box.delete(key);
    }
  }
}
