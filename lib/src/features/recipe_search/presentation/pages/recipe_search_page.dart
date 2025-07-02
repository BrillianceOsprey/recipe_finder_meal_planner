import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../recipe_details/presentation/pages/recipe_detail_page.dart';
import '../controllers/recipe_search_controller.dart';
import '../controllers/recipe_search_providers.dart';

class RecipeSearchPage extends ConsumerStatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  ConsumerState<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends ConsumerState<RecipeSearchPage> {
  final TextEditingController _ingredientController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> ingredients = [];
  int page = 0; // For pagination
  final FocusNode _ingredientFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      _onSearch();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }

  void _onAddIngredients(String value) {
    final entries = value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && !ingredients.contains(e))
        .toList();
    if (entries.isNotEmpty) {
      setState(() {
        ingredients.addAll(entries);
      });
      _ingredientController.clear();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      // Load more recipes when close to bottom
      final state = ref.read(recipeSearchControllerProvider);
      if (!state.isLoadingMore && state.hasMore) {
        ref.read(recipeSearchControllerProvider.notifier).loadMore(ingredients);
      }
    }
  }

  void _onSearch() {
    setState(() {
      page = 0;
    });
    _ingredientFocusNode.unfocus();
    ref.read(recipeSearchControllerProvider.notifier).search(ingredients);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeSearchControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Finder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Modern Ingredient Input
            TextField(
              controller: _ingredientController,
              focusNode: _ingredientFocusNode,
              decoration: const InputDecoration(
                hintText: 'Enter ingredients (e.g. tomato, cheese, chicken)',
                labelText: 'Ingredients',
                helperText:
                    'Add ingredients separated by commas, then press Enter or tap +',
                suffixIcon: Icon(Icons.kitchen),
              ),
              onSubmitted: _onAddIngredients,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 0,
                children: ingredients
                    .map((e) => Chip(
                          label: Text(e),
                          onDeleted: () {
                            setState(() {
                              ingredients.remove(e);
                            });
                          },
                        ))
                    .toList(),
              ),
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                  onPressed: () =>
                      _onAddIngredients(_ingredientController.text),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                  onPressed: ingredients.isEmpty ? null : _onSearch,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(height: 24),
            // Recipe List with Pagination
            Expanded(
              child: state.status == RecipeSearchStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : state.status == RecipeSearchStatus.error
                      ? Center(child: Text(state.error ?? 'Error'))
                      : state.recipes.isEmpty
                          ? const Center(child: Text('No recipes found.'))
                          : GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.85,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: state.recipes.length +
                                  (state.isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index >= state.recipes.length) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                final recipe = state.recipes[index];
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      _ingredientFocusNode.unfocus();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => RecipeDetailPage(
                                            recipeId: recipe.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: recipe.image != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              16)),
                                                  child: Image.network(
                                                    recipe.image!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            recipe.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
            ),
            // Load More Button (optional, in addition to infinite scroll)
            if (state.hasMore && !state.isLoadingMore)
              ElevatedButton(
                onPressed: () => ref
                    .read(recipeSearchControllerProvider.notifier)
                    .loadMore(ingredients),
                child: const Text('Load More'),
              ),
          ],
        ),
      ),
    );
  }
}
