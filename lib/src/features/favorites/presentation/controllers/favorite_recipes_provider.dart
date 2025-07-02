import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../recipe_search/domain/models/recipe.dart';
import '../../../recipe_search/presentation/controllers/recipe_search_providers.dart';
import 'favorite_provider.dart';

final favoriteRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final ids = ref.watch(favoritesProvider);
  final repo = ref.read(recipeSearchRepositoryProvider);
  return await repo.getRecipesByIds(ids);
});
