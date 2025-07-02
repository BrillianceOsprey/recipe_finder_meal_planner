import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/recipe_search_repository.dart';
import '../../domain/models/recipe.dart';

enum RecipeSearchStatus { initial, loading, loaded, loadingMore, error }

class RecipeSearchState {
  final RecipeSearchStatus status;
  final List<Recipe> recipes;
  final String? error;
  final int offset;
  final bool hasMore;
  final bool isLoadingMore;

  RecipeSearchState({
    this.status = RecipeSearchStatus.initial,
    this.recipes = const [],
    this.error,
    this.offset = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  RecipeSearchState copyWith({
    RecipeSearchStatus? status,
    List<Recipe>? recipes,
    String? error,
    int? offset,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return RecipeSearchState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      error: error,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class RecipeSearchController extends StateNotifier<RecipeSearchState> {
  final RecipeSearchRepository repository;
  static const int _pageSize = 10;

  RecipeSearchController(this.repository) : super(RecipeSearchState());

  List<String> _currentIngredients = [];

  Future<void> search(List<String> ingredients) async {
    state = state.copyWith(
      status: RecipeSearchStatus.loading,
      error: null,
      offset: 0,
      hasMore: true,
      isLoadingMore: false,
      recipes: [],
    );
    _currentIngredients = List.from(ingredients);

    try {
      final results = await repository.searchRecipes(
        ingredients,
        offset: 0,
        number: _pageSize,
      );
      state = state.copyWith(
        status: RecipeSearchStatus.loaded,
        recipes: results,
        offset: results.length,
        hasMore: results.length == _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        status: RecipeSearchStatus.error,
        error: e.toString(),
        hasMore: false,
      );
    }
  }

  Future<void> loadMore(List<String> ingredients) async {
    // Prevent duplicate loads or loading if no more data
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final results = await repository.searchRecipes(
        ingredients,
        offset: state.offset,
        number: _pageSize,
      );
      state = state.copyWith(
        recipes: [...state.recipes, ...results],
        offset: state.offset + results.length,
        hasMore: results.length == _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: RecipeSearchStatus.error,
        error: e.toString(),
        isLoadingMore: false,
      );
    }
  }
}
