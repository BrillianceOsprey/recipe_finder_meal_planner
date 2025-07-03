import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder_meal_planner/src/core/utils/html_utils.dart';
import 'package:recipe_finder_meal_planner/src/features/recipe_search/domain/models/recipe.dart';
import '../../../favorites/presentation/controllers/favorite_provider.dart';
import '../controllers/recipe_detail_controller.dart';
import '../controllers/recipe_detail_providers.dart';
import '../widgets/about_section.dart';
import '../widgets/ingredients_section.dart';
import '../widgets/instructions_section.dart';
import '../widgets/nutrition_section.dart';
import '../widgets/recipe_detail_shimmer.dart';
import '../widgets/info_icon_text.dart';

class RecipeDetailPage extends ConsumerStatefulWidget {
  final int recipeId;
  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  ConsumerState<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends ConsumerState<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(recipeDetailControllerProvider.notifier)
          .loadRecipeDetail(widget.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipeDetailControllerProvider);
    final favorites = ref.watch(favoritesProvider);
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    final isFav = favorites.any((r) => r.id == state.recipeDetail?.id);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (state.status == RecipeDetailStatus.loading) {
      return const RecipeDetailShimmer();
    } else if (state.status == RecipeDetailStatus.error) {
      return errorWidget(state, isDark);
    } else if (state.status == RecipeDetailStatus.loaded &&
        state.recipeDetail != null) {
      final detail = state.recipeDetail!;

      final calories = (detail.nutrition?.nutrients ?? [])
          .where((n) => n.name.toLowerCase().contains('calorie'))
          .toList();
      final caloriesLabel = calories.isNotEmpty
          ? "${calories.first.amount.toStringAsFixed(0)} kcal"
          : "-- kcal";

      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              foregroundColor: Colors.white,
              stretch: true,
              backgroundColor: Colors.green[700],
              flexibleSpace: FlexibleSpaceBar(
                background: _buildHeaderImage(detail.image!, detail.id),
                title: Text(
                  detail.title,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
              actions: [
                _buildFavoriteButton(
                  isFav,
                  favoritesNotifier,
                  Recipe(
                    id: detail.id,
                    title: detail.title,
                    image: detail.image,
                    imageType: 'png',
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoIconText(
                                icon: Icons.timer,
                                label: "${detail.readyInMinutes} min"),
                            InfoIconText(
                                icon: Icons.restaurant,
                                label: "Serves ${detail.servings}"),
                            InfoIconText(
                                icon: Icons.star, label: caloriesLabel),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (detail.summary != null)
                      AboutSection(summary: parseHtmlString(detail.summary!)),
                    IngredientsSection(
                        ingredients: detail.extendedIngredients ?? []),
                    InstructionsSection(
                        instructions: detail.analyzedInstructions ?? []),
                    if (detail.nutrition != null &&
                        detail.nutrition!.nutrients.isNotEmpty)
                      NutritionSection(nutrients: detail.nutrition!.nutrients),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Scaffold(body: Center(child: Text('No details found.')));
    }
  }

  Scaffold errorWidget(RecipeDetailState state, bool isDark) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            Text(
              state.error.toString().contains('The connection errored:')
                  ? "Check your internet connection\n and press on reload"
                  : state.error.toString().contains(
                          'This exception was thrown because the response has a status code')
                      ? "Your Token has expired"
                      : state.error ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(String imageUrl, int id) => Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'recipe_image_$id',
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (c, o, s) => const ColoredBox(color: Colors.grey),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black26, Colors.transparent, Colors.black12],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      );

  Widget _buildFavoriteButton(bool isFav, favoritesNotifier, Recipe detail) =>
      Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 8),
        child: CircleAvatar(
          backgroundColor: Colors.white70,
          child: IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.red[400],
            ),
            onPressed: () {
              if (isFav) {
                favoritesNotifier.removeFavorite(detail.id);
              } else {
                favoritesNotifier.addFavorite(Recipe(
                  id: detail.id,
                  title: detail.title,
                  image: detail.image,
                  imageType: 'png',
                ));
              }
            },
          ),
        ),
      );
}
