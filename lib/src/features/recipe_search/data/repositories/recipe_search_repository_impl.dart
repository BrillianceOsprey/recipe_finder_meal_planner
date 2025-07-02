import '../../domain/models/recipe.dart';
import '../datasources/recipe_search_remote_datasource.dart';
import 'recipe_search_repository.dart';

class RecipeSearchRepositoryImpl implements RecipeSearchRepository {
  final RecipeSearchRemoteDatasource remoteDatasource;

  RecipeSearchRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Recipe>> searchRecipes(
    List<String> ingredients, {
    int offset = 0,
    int number = 10,
  }) {
    return remoteDatasource.searchRecipes(
      ingredients,
      offset: offset,
      number: number,
    );
  }

  @override
  Future<List<Recipe>> getRecipesByIds(List<int> ids) {
    return remoteDatasource
        .getRecipesByIds(ids); // Implement in datasource too!
  }
}
