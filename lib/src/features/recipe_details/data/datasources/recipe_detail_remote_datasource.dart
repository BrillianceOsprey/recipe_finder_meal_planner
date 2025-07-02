import 'package:dio/dio.dart';
import '../../domain/models/recipe_detail.dart';
import '../../../../core/network/api_client.dart';

class RecipeDetailRemoteDatasource {
  final ApiClient apiClient;

  RecipeDetailRemoteDatasource(this.apiClient);

  Future<RecipeDetail> fetchRecipeDetail(int id) async {
    try {
      final response = await apiClient.dio.get(
        'recipes/$id/information',
        queryParameters: {
          'includeNutrition': true, // Set to false if you don't want nutrition
        },
      );
      return RecipeDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch recipe detail: ${e.message}');
    }
  }
}
