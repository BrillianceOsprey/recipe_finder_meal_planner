import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder_meal_planner/src/core/providers/connectivity_provider.dart';
import 'package:recipe_finder_meal_planner/src/core/widgets/offline_dialog.dart';

import '../../../favorites/presentation/controllers/favorite_recipes_provider.dart';
import '../../../recipe_details/presentation/pages/recipe_detail_page.dart';
import '../../../recipe_search/domain/models/recipe.dart';
import '../controllers/meal_plan_providers.dart';

class MealPlannerPage extends HookConsumerWidget {
  const MealPlannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityResult = ref.watch(connectivityProvider);
    final mealPlanState = ref.watch(mealPlanControllerProvider);
    final mealPlanAsync = ref.read(mealPlanControllerProvider.notifier);
    final favoriteRecipesAsync = ref.watch(favoriteRecipesProvider);

    final daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    useEffect(() {
      Future.microtask(() {
        mealPlanAsync.load();
      });
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
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
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Clear All Meal Plans?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "This will remove all recipes from every day. This action cannot be undone.",
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_outlined,
                              color: Colors.amber[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Are you sure you want to continue?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.amber[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.delete, size: 18),
                      label: const Text(
                        "Clear All",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                if (context.mounted) {
                  ref.read(mealPlanControllerProvider.notifier).clearAll();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("All meal plans cleared!")),
                  );
                }
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF6B6B),
                  Color(0xFFFFE66D),
                ],
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
                            mealPlanState.mealPlan.recipesByday[day] ?? [];

                        // Retrieve the Recipe objects using their IDs
                        final recipes = favorites.where((recipe) {
                          return recipeIds.contains(recipe.id);
                        }).toList();

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Card(
                            color: Colors.white,
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
                              subtitle: Text(
                                '${recipes.length} recipes',
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
                                if (recipes.isEmpty)
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
                                  ...recipes.map((recipe) {
                                    return AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: ListTile(
                                        key: ValueKey(recipe.id),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: recipe.image != null
                                              ? CachedNetworkImage(
                                                  imageUrl: recipe.image!,
                                                  width: 46,
                                                  height: 46,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            const CircularProgressIndicator()),
                                                  ), // Show a loading indicator while the image is loading
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    Icons.restaurant,
                                                    size: 46,
                                                    color: Colors.teal,
                                                  ), // Show an error icon if the image fails to load
                                                )
                                              : const Icon(
                                                  Icons.restaurant,
                                                  size: 46,
                                                  color: Colors.teal,
                                                ),
                                        ),
                                        title: Text(
                                          recipe.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onTap: () {
                                          connectivityResult.whenData((value) {
                                            bool isOnline = value ==
                                                    ConnectivityResult.wifi ||
                                                value ==
                                                    ConnectivityResult.mobile;
                                            if (isOnline) {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (_) =>
                                                    RecipeDetailPage(
                                                        recipeId: recipe.id),
                                              ));
                                            } else {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return OfflineAlertDialog(
                                                    title: "Connection Lost",
                                                    message:
                                                        "Please check your internet connection and try again.",
                                                    onRetry: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    onCancel: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                },
                                              );
                                            }
                                          });
                                        },
                                        trailing: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            ref
                                                .read(mealPlanControllerProvider
                                                    .notifier)
                                                .removeRecipe(day, recipe.id);
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
                                            recipes,
                                            favorites,
                                          );
                                        },
                                      ),
                                      const Spacer(),
                                      if (recipes.isNotEmpty)
                                        TextButton.icon(
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.redAccent,
                                          ),
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
    List<Recipe> recipesForDay,
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
                                recipesForDay.contains(recipe);
                            return ListTile(
                              leading: recipe.image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: recipe.image!,
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child:
                                                const CircularProgressIndicator(),
                                          ),
                                        ), // Show a loading indicator while the image is loading
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.restaurant,
                                          size: 48,
                                          color: Colors.teal,
                                        ), // Show an error icon if the image fails to load
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
                                          .addRecipe(day, recipe);
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
