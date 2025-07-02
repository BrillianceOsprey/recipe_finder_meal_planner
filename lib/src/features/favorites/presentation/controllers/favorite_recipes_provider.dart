import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/connectivity_provider.dart';
import '../../../recipe_search/domain/models/recipe.dart';
import '../../../recipe_search/presentation/controllers/recipe_search_providers.dart';
import 'favorite_provider.dart';

final favoriteRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final favorites = ref.watch(favoritesProvider);
  final repo = ref.read(recipeSearchRepositoryProvider);

  // Fetch the current connectivity status
  final connectivityResult = await ref.watch(connectivityProvider.future);

  // If the app is online, fetch the recipes from the API
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    final ids = favorites.map((recipe) => recipe.id).toList();
    return await repo.getRecipesByIds(ids);
  } else {
    // If offline, fetch from Hive (local storage)
    final localRepo = ref.read(favoriteRepositoryProvider);
    return localRepo.getFavoriteRecipes();
  }
});
