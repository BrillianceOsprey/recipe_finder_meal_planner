import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import connectivity_plus
import '../../../../core/providers/connectivity_provider.dart';
import '../../../../core/widgets/offline_dialog.dart';
import '../../../recipe_details/presentation/pages/recipe_detail_page.dart';
import '../controllers/favorite_provider.dart';
import '../controllers/favorite_recipes_provider.dart';

// Listen to the stream of connectivity changes
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityResult =
        ref.watch(connectivityProvider); // Listen to connectivity stream
    final favoriteRecipesAsync = ref.watch(favoriteRecipesProvider);
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
// Get the width of the screen for calculating aspect ratio
    double screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate childAspectRatio based on screen width
    double childAspectRatio = screenWidth / (screenWidth * 1.2);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Customize the height as needed
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF6B6B),
                Color(0xFFFFE66D),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text('Favorites'),
            centerTitle: false,
            backgroundColor:
                Colors.transparent, // Transparent so gradient is visible
            elevation: 0, // Remove shadow
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: connectivityResult.when(
          data: (result) {
            bool isOnline = result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi;

            return favoriteRecipesAsync.when(
              loading: () => _FavoritesShimmer(),
              error: (e, st) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restart_alt,
                      size: 64,
                      color: const Color(0xFF4ECDC4),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      e.toString().contains('The connection errored:')
                          ? "Check your internet connection\n and press on reload"
                          : e.toString().contains(
                                  'This exception was thrown because the response has a status code')
                              ? "Your Token has expired"
                              : e.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              data: (recipes) {
                if (isOnline) {
                  // If online, show fetched recipes
                  if (recipes.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite_border,
                              size: 72, color: Colors.grey[400]),
                          const SizedBox(height: 12),
                          Text('No favorites yet',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[600])),
                          const SizedBox(height: 6),
                          Text('Add some recipes to see them here!'),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    itemCount: recipes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, idx) {
                      final recipe = recipes[idx];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  RecipeDetailPage(recipeId: recipe.id),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black26,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                    child: recipe.image != null
                                        ? CachedNetworkImage(
                                            imageUrl: recipe.image!,
                                            height: 120,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: SizedBox(
                                                height:
                                                    50, // Fixed size for the loading indicator
                                                width:
                                                    50, // Fixed size for the loading indicator
                                                child:
                                                    const CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.restaurant,
                                              size: 46,
                                              color: Colors.teal,
                                            ),
                                          )
                                        : Container(
                                            height: 120,
                                            color: Colors.grey[200],
                                            child: const Icon(Icons.restaurant,
                                                size: 48),
                                          ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(24),
                                        onTap: () {
                                          favoritesNotifier
                                              .removeFavorite(recipe.id);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                              Icons.favorite_rounded,
                                              color: Colors.redAccent,
                                              size: 26),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 8),
                                  child: Text(
                                    recipe.title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal[800], // Dark Teal Text
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // If offline, show locally saved recipes and an offline message
                  return _offlineMessage(ref);
                }
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) =>
              Center(child: Text('Failed to detect connectivity')),
        ),
      ),
    );
  }

  // Offline message with locally saved recipes
  Widget _offlineMessage(WidgetRef ref) {
    final localRecipes =
        ref.watch(favoriteRecipesProvider); // Fetch local recipes if offline
    return Center(
      child: localRecipes.when(
        loading: () => const CircularProgressIndicator(),
        error: (e, st) => const Text("Error loading local favorites"),
        data: (recipes) {
          if (recipes.isEmpty) {
            return const Text("No recipes available offline.");
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 72, color: Colors.grey),
              const SizedBox(height: 12),
              const Text('You are offline',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 6),
              const Text('Showing locally saved recipes.'),
              Expanded(
                child: GridView.builder(
                  itemCount: recipes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, idx) {
                    final recipe = recipes[idx];
                    return GestureDetector(
                      onTap: () async {
                        // Offline case :Myat Soe

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return OfflineAlertDialog(
                              title: "Connection Lost",
                              message:
                                  "Please check your internet connection and try again.",
                              onRetry: () {
                                Navigator.of(context).pop();
                              },
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (_) =>
                        //         RecipeDetailPage(recipeId: recipe.id),
                        //   ),
                        // );
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        shadowColor: Colors.black26,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                  child: recipe.image != null
                                      ? CachedNetworkImage(
                                          imageUrl: recipe.image!,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child:
                                                  const CircularProgressIndicator(),
                                            ),
                                          ), // Show a loading indicator while the image is loading
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.restaurant,
                                            size: 46,
                                            color: Colors.teal,
                                          ), // Show an error icon if the image fails to load
                                        )
                                      : Container(
                                          height: 120,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.restaurant,
                                              size: 48),
                                        ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(24),
                                      onTap: () {
                                        ref
                                            .read(favoritesProvider.notifier)
                                            .removeFavorite(recipe.id);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.redAccent,
                                            size: 26),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 12, 12, 8),
                                child: Text(
                                  recipe.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800], // Dark Teal Text
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FavoritesShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, idx) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 16),
                        SizedBox(height: 12, width: 60),
                        Spacer(),
                      ],
                    ),
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
