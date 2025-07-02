import '../../domain/models/recipe_detail.dart';
import '../datasources/recipe_detail_remote_datasource.dart';
import 'recipe_detail_repository.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  final RecipeDetailRemoteDatasource remoteDatasource;

  RecipeDetailRepositoryImpl(this.remoteDatasource);

  @override
  Future<RecipeDetail> getRecipeDetail(int id) {
    return remoteDatasource.fetchRecipeDetail(id);
  }
}
