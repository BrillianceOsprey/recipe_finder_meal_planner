import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/recipe_detail_repository.dart';
import '../../domain/models/recipe_detail.dart';

enum RecipeDetailStatus { initial, loading, loaded, error }

class RecipeDetailState {
  final RecipeDetailStatus status;
  final RecipeDetail? recipeDetail;
  final String? error;

  RecipeDetailState({
    this.status = RecipeDetailStatus.initial,
    this.recipeDetail,
    this.error,
  });

  RecipeDetailState copyWith({
    RecipeDetailStatus? status,
    RecipeDetail? recipeDetail,
    String? error,
  }) {
    return RecipeDetailState(
      status: status ?? this.status,
      recipeDetail: recipeDetail ?? this.recipeDetail,
      error: error,
    );
  }
}

class RecipeDetailController extends StateNotifier<RecipeDetailState> {
  final RecipeDetailRepository repository;

  RecipeDetailController(this.repository) : super(RecipeDetailState());

  Future<void> loadRecipeDetail(int id) async {
    state = state.copyWith(status: RecipeDetailStatus.loading, error: null);
    try {
      final detail = await repository.getRecipeDetail(id);
      state = state.copyWith(
        status: RecipeDetailStatus.loaded,
        recipeDetail: detail,
      );
    } catch (e) {
      state = state.copyWith(
        status: RecipeDetailStatus.error,
        error: e.toString(),
      );
    }
  }
}
