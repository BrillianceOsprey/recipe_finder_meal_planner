import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/recipe_search_remote_datasource.dart';
import '../../data/repositories/recipe_search_repository.dart';
import '../../data/repositories/recipe_search_repository_impl.dart';
import 'recipe_search_controller.dart';

// ApiClient provider
final apiClientProvider = Provider((ref) => ApiClient());

// Remote datasource provider
final recipeSearchRemoteDatasourceProvider = Provider(
  (ref) => RecipeSearchRemoteDatasource(ref.watch(apiClientProvider)),
);

// Repository provider
final recipeSearchRepositoryProvider = Provider<RecipeSearchRepository>(
  (ref) => RecipeSearchRepositoryImpl(
      ref.watch(recipeSearchRemoteDatasourceProvider)),
);

final recipeSearchControllerProvider =
    StateNotifierProvider<RecipeSearchController, RecipeSearchState>(
  (ref) => RecipeSearchController(ref.watch(recipeSearchRepositoryProvider)),
);
