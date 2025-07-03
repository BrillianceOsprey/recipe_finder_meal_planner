import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder_meal_planner/src/features/recipe_search/data/repositories/recipe_search_repository_impl.dart';
import 'package:recipe_finder_meal_planner/src/features/recipe_search/domain/models/recipe.dart';

import '../mock/mock_recipe_search_remote_datasource.mocks.dart';

void main() {
  late MockRecipeSearchRemoteDatasource mockDatasource;
  late RecipeSearchRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockRecipeSearchRemoteDatasource();
    repository = RecipeSearchRepositoryImpl(mockDatasource);
  });

  group('searchRecipes', () {
    test('should return list of recipes from datasource', () async {
      final ingredients = ['chicken', 'rice'];
      final recipes = [
        Recipe(id: 1, title: 'Chicken Rice', image: 'image.png'),
      ];

      when(mockDatasource.searchRecipes(ingredients, offset: 0, number: 10))
          .thenAnswer((_) async => recipes);

      final result = await repository.searchRecipes(ingredients);

      expect(result, recipes);
      verify(mockDatasource.searchRecipes(ingredients, offset: 0, number: 10))
          .called(1);
    });
  });

  group('getRecipesByIds', () {
    test('should return recipes by ids from datasource', () async {
      final ids = [1, 2];
      final recipes = [
        Recipe(id: 1, title: 'Pasta', image: 'pasta.png'),
        Recipe(id: 2, title: 'Salad', image: 'salad.png'),
      ];

      when(mockDatasource.getRecipesByIds(ids))
          .thenAnswer((_) async => recipes);

      final result = await repository.getRecipesByIds(ids);

      expect(result, recipes);
      verify(mockDatasource.getRecipesByIds(ids)).called(1);
    });
  });
}
