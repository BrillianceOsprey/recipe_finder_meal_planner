import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/models/recipe.dart';

class RecipeSearchRemoteDatasource {
  final ApiClient apiClient;

  RecipeSearchRemoteDatasource(this.apiClient);

  Future<List<Recipe>> searchRecipes(
    List<String> ingredients, {
    int offset = 0,
    int number = 10,
  }) async {
    try {
      final response = await apiClient.dio.get(
        'recipes/complexSearch',
        queryParameters: {
          'includeIngredients': ingredients.join(','),
          'number': number,
          'offset': offset,
          'addRecipeInformation': false,
        },
      );
      debugPrint('request URL: ${response.requestOptions.uri}');
      final List<dynamic> results = response.data['results'];
      return results.map((e) => Recipe.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch recipes: ${e.message}');
    }
  }

  Future<List<Recipe>> getRecipesByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    try {
      final response = await apiClient.dio.get(
        'recipes/informationBulk',
        queryParameters: {
          'ids': ids.join(','),
        },
      );
      debugPrint('Bulk request URL: ${response.requestOptions.uri}');
      final List<dynamic> results = response.data;
      return results.map((e) => Recipe.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch recipes by IDs: ${e.message}');
    }
  }
}
