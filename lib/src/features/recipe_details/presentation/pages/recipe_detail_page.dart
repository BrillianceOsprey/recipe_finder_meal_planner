import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder_meal_planner/src/core/utils/html_utils.dart';
import '../../../favorites/presentation/controllers/favorite_provider.dart';
import '../controllers/recipe_detail_controller.dart';
import '../controllers/recipe_detail_providers.dart';
import '../widgets/recipe_detail_shimmer.dart';

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
    final isFav = favorites.contains(state.recipeDetail?.id ?? 0);

    if (state.status == RecipeDetailStatus.loading) {
      return const RecipeDetailShimmer();
    } else if (state.status == RecipeDetailStatus.error) {
      return Scaffold(body: Center(child: Text(state.error ?? 'Error')));
    } else if (state.status == RecipeDetailStatus.loaded &&
        state.recipeDetail != null) {
      final detail = state.recipeDetail!;

      // Calories calculation - safe
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
            // Parallax SliverAppBar with Hero Image
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'recipe_image_${detail.id}',
                      child: Image.network(
                        detail.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (c, o, s) =>
                            const ColoredBox(color: Colors.grey),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black26,
                            Colors.transparent,
                            Colors.black12
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
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
                          favoritesNotifier.addFavorite(detail.id);
                        }
                      },
                    ),
                  ),
                )
              ],
              backgroundColor: Colors.green[700],
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Info Card
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _InfoIconText(
                                icon: Icons.timer,
                                label: "${detail.readyInMinutes} min"),
                            _InfoIconText(
                                icon: Icons.restaurant,
                                label: "Serves ${detail.servings}"),
                            _InfoIconText(
                              icon: Icons.star,
                              label: caloriesLabel,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (detail.summary != null)
                      Text(
                        parseHtmlString(detail.summary!),
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black87),
                      ),
                    const SizedBox(height: 28),

                    // Ingredients Section
                    Text("Ingredients",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            for (final e in detail.extendedIngredients ?? [])
                              Chip(
                                avatar: e.image != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://spoonacular.com/cdn/ingredients_100x100/${e.image}',
                                        ),
                                      )
                                    : null,
                                label: Text(e.name),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Instructions Section
                    Text("Instructions",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (detail.analyzedInstructions != null &&
                                detail.analyzedInstructions!.isNotEmpty)
                              ...detail.analyzedInstructions!.first.steps.map(
                                (step) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 2, right: 12),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green[400],
                                        radius: 16,
                                        child: Text('${step.number}',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(step.step,
                                            style:
                                                const TextStyle(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Nutrition Section
                    if (detail.nutrition != null &&
                        detail.nutrition!.nutrients.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 26.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nutrition',
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 6,
                                  children: detail.nutrition!.nutrients
                                      .take(8)
                                      .map((n) => Chip(
                                            label: Text(
                                                '${n.name}: ${n.amount}${n.unit}'),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}

class _InfoIconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoIconText({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.green[400], size: 26),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
