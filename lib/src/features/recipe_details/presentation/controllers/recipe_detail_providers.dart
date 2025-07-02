import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../recipe_search/presentation/controllers/recipe_search_providers.dart';
import '../../data/datasources/recipe_detail_remote_datasource.dart';
import '../../data/repositories/recipe_detail_repository_impl.dart';
import '../../presentation/controllers/recipe_detail_controller.dart';

final recipeDetailRemoteDatasourceProvider = Provider(
  (ref) => RecipeDetailRemoteDatasource(ref.read(apiClientProvider)),
);

final recipeDetailRepositoryProvider = Provider(
  (ref) => RecipeDetailRepositoryImpl(
      ref.read(recipeDetailRemoteDatasourceProvider)),
);

final recipeDetailControllerProvider = StateNotifierProvider.autoDispose<
    RecipeDetailController, RecipeDetailState>(
  (ref) => RecipeDetailController(ref.read(recipeDetailRepositoryProvider)),
);
