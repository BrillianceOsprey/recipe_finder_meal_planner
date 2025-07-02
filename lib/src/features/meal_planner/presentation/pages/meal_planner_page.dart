import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../../favorites/presentation/controllers/favorite_recipes_provider.dart';
import '../../../recipe_details/presentation/pages/recipe_detail_page.dart';
import '../../../recipe_search/domain/models/recipe.dart';
import '../controllers/meal_plan_providers.dart';

class MealPlannerPage extends ConsumerWidget {
  const MealPlannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealPlanState = ref.watch(mealPlanControllerProvider);
    final favoriteRecipesAsync = ref.watch(favoriteRecipesProvider);
    print("Meal Plan Data ${mealPlanState.mealPlan.days}");

    final daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Meal Planner'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: "Clear All Meal Plans",
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text("Clear All Meal Plans?"),
                  content: const Text(
                    "This will remove all recipes from every day. Are you sure?",
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      child: const Text("Clear All"),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                ref.read(mealPlanControllerProvider.notifier).clearAll();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All meal plans cleared!")),
                );
              }
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43cea2), Color(0xFF185a9d)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              // Motivational header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.calendar_month,
                          color: Colors.teal, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Plan your week!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 2, color: Colors.black26)
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Add your favorite recipes to each day.\nStay healthy, stay organized! 🥗",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Main list
              Expanded(
                child: favoriteRecipesAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) =>
                      Center(child: Text('Error loading favorites')),
                  data: (List<Recipe> favorites) {
                    return ListView.builder(
                      itemCount: daysOfWeek.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, dayIdx) {
                        final day = daysOfWeek[dayIdx];
                        final recipeIds =
                            mealPlanState.mealPlan.days[day] ?? [];

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              title: Text(
                                day,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal[100],
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Icon(Icons.calendar_today,
                                    color: Colors.teal[700]),
                              ),
                              children: [
                                if (recipeIds.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.emoji_food_beverage,
                                            size: 48, color: Colors.grey[400]),
                                        const SizedBox(height: 10),
                                        Text(
                                          'No recipes planned.',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[600]),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap "Add Recipe" to fill your day!',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[500]),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  ...recipeIds.map((id) {
                                    final recipe = favorites
                                        .firstWhereOrNull((r) => r.id == id);
                                    if (recipe == null) {
                                      return ListTile(
                                        leading: const Icon(Icons.error,
                                            color: Colors.redAccent),
                                        title: const Text(
                                            'Recipe not found (maybe deleted from favorites)'),
                                      );
                                    }
                                    return AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: ListTile(
                                        key: ValueKey(recipe.id),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: recipe.image != null
                                              ? Image.network(recipe.image!,
                                                  width: 46,
                                                  height: 46,
                                                  fit: BoxFit.cover)
                                              : const Icon(Icons.restaurant,
                                                  size: 46, color: Colors.teal),
                                        ),
                                        title: Text(
                                          recipe.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (_) => RecipeDetailPage(
                                                recipeId: recipe.id),
                                          ));
                                        },
                                        trailing: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            ref
                                                .read(mealPlanControllerProvider
                                                    .notifier)
                                                .removeRecipe(day, id);
                                          },
                                          tooltip: "Remove from $day",
                                        ),
                                      ),
                                    );
                                  }),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 12, top: 4),
                                  child: Row(
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal[400],
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 2,
                                        ),
                                        icon: const Icon(Icons.add),
                                        label: const Text('Add Recipe'),
                                        onPressed: () {
                                          _showFavoriteRecipePicker(
                                            context,
                                            day,
                                            ref,
                                            recipeIds,
                                            favorites,
                                          );
                                        },
                                      ),
                                      const Spacer(),
                                      if (recipeIds.isNotEmpty)
                                        TextButton.icon(
                                          icon: const Icon(Icons.delete_outline,
                                              color: Colors.redAccent),
                                          label: const Text('Clear Day',
                                              style: TextStyle(
                                                  color: Colors.redAccent)),
                                          onPressed: () {
                                            ref
                                                .read(mealPlanControllerProvider
                                                    .notifier)
                                                .clearDay(day);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Cleared all recipes from $day!")),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFavoriteRecipePicker(
    BuildContext context,
    String day,
    WidgetRef ref,
    List<int> recipeIdsForDay,
    List<Recipe> favorites,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.grey[50],
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: favorites.isEmpty
                ? const Center(child: Text('No favorites found!'))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Pick a favorite for $day",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Divider(height: 24, thickness: 1),
                      Expanded(
                        child: ListView.separated(
                          itemCount: favorites.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, idx) {
                            final recipe = favorites[idx];
                            final isAlreadyAdded =
                                recipeIdsForDay.contains(recipe.id);
                            return ListTile(
                              leading: recipe.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        recipe.image!,
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(Icons.restaurant, size: 48),
                              title: Text(recipe.title,
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              trailing: isAlreadyAdded
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : const Icon(Icons.add_circle_outline,
                                      color: Colors.green),
                              enabled: !isAlreadyAdded,
                              onTap: isAlreadyAdded
                                  ? null
                                  : () {
                                      ref
                                          .read(mealPlanControllerProvider
                                              .notifier)
                                          .addRecipe(day, recipe.id);
                                      Navigator.of(ctx).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                '${recipe.title} added to $day!')),
                                      );
                                    },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
