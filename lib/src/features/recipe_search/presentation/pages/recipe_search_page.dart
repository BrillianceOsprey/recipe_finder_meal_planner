import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../favorites/presentation/controllers/favorite_provider.dart';
import '../../../recipe_details/presentation/pages/recipe_detail_page.dart';
import '../../domain/models/recipe.dart';
import '../controllers/recipe_search_controller.dart';
import '../controllers/recipe_search_providers.dart';

class RecipeSearchPage extends ConsumerStatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  ConsumerState<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends ConsumerState<RecipeSearchPage>
    with TickerProviderStateMixin {
  final TextEditingController _ingredientController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _ingredientFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<String> ingredients = [];
  int page = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scrollController.addListener(_onScroll);
    _animationController.forward();

    Future.microtask(() {
      _onSearch();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _ingredientController.dispose();
    _ingredientFocusNode.dispose();
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
    final favorites = ref.watch(favoritesProvider);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0A0A0A) : const Color(0xFFFAFAFA),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Recipe Finder',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            const Color(0xFF2D2D2D),
                            const Color(0xFF1A1A1A),
                          ]
                        : [
                            const Color(0xFFFF6B6B),
                            const Color(0xFFFFE66D),
                          ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Section
                    _buildSearchSection(isDark),
                    const SizedBox(height: 24),

                    // Ingredients Section
                    if (ingredients.isNotEmpty) ...[
                      _buildIngredientsSection(isDark),
                      const SizedBox(height: 24),
                    ],

                    // Action Buttons
                    _buildActionButtons(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),

          // Recipe Grid
          _buildRecipeGrid(state, isDark, favorites),

          // Load More Section
          if (state.hasMore && !state.isLoadingMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: _buildLoadMoreButton(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What\'s in your kitchen?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add ingredients to find perfect recipes',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ingredientController,
              focusNode: _ingredientFocusNode,
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF2D2D2D),
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Enter ingredients (e.g. tomato, cheese, chicken)',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
                filled: true,
                fillColor:
                    isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF8F8F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF6B6B),
                    width: 2,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.kitchen,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onSubmitted: _onAddIngredients,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Ingredients',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ingredients.map((ingredient) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF6B6B),
                      Color(0xFFFFE66D),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B6B).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ingredient,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          ingredients.remove(ingredient);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _onAddIngredients(_ingredientController.text),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Ingredient'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4ECDC4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              shadowColor: const Color(0xFF4ECDC4).withValues(alpha: 0.4),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: ingredients.isEmpty ? null : _onSearch,
            icon: const Icon(Icons.search_rounded),
            label: const Text('Find Recipes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B6B),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[600],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              shadowColor: const Color(0xFFFF6B6B).withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeGrid(
      RecipeSearchState state, bool isDark, List<Recipe> favorites) {
    if (state.status == RecipeSearchStatus.loading) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6B6B)),
            ),
          ),
        ),
      );
    }

    if (state.status == RecipeSearchStatus.error) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _onSearch();
                  },
                  child: Icon(
                    Icons.restart_alt,
                    size: 64,
                    color: const Color(0xFF4ECDC4),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  textAlign: TextAlign.center,
                  state.error.toString().contains('The connection errored:')
                      ? "Check your internet connection\n and press on reload"
                      : state.error.toString().contains(
                              'This exception was thrown because the response has a status code')
                          ? "Your Token has expired"
                          : state.error ?? 'Something went wrong',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      );
    }

    if (state.recipes.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant_menu_rounded,
                  size: 64,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  'No recipes found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adding some ingredients to discover recipes',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= state.recipes.length) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6B6B)),
                ),
              );
            }

            final recipe = state.recipes[index];
            return _buildRecipeCard(recipe, isDark, favorites);
          },
          childCount: state.recipes.length + (state.isLoadingMore ? 1 : 0),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe, bool isDark, List<Recipe> favorites) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _ingredientFocusNode.unfocus();
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            RecipeDetailPage(recipeId: recipe.id),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween(
                                      begin: const Offset(1.0, 0.0),
                                      end: Offset.zero)
                                  .chain(CurveTween(curve: Curves.easeInOut)),
                            ),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: recipe.image != null
                            ? Stack(
                                children: [
                                  Image.network(
                                    recipe.image!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(alpha: 0.1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                color: isDark
                                    ? const Color(0xFF2D2D2D)
                                    : const Color(0xFFF0F0F0),
                                child: const Icon(
                                  Icons.restaurant_rounded,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF2D2D2D),
                                  height: 1.3,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 16,
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Quick & Easy',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8),
            child: CircleAvatar(
              backgroundColor: Colors.white70,
              child: IconButton(
                icon: Icon(
                  favorites.any((r) => r.id == recipe.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red[400],
                ),
                onPressed: () {
                  if (favorites.any((r) => r.id == recipe.id)) {
                    ref
                        .read(favoritesProvider.notifier)
                        .removeFavorite(recipe.id);
                  } else {
                    ref.read(favoritesProvider.notifier).addFavorite(
                          Recipe(
                            id: recipe.id,
                            title: recipe.title,
                            image: recipe.image,
                            imageType: 'png',
                          ),
                        );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return ElevatedButton(
      onPressed: () => ref
          .read(recipeSearchControllerProvider.notifier)
          .loadMore(ingredients),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFE66D),
        foregroundColor: const Color(0xFF2D2D2D),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        shadowColor: const Color(0xFFFFE66D).withValues(alpha: 0.4),
      ),
      child: const Text(
        'Load More Recipes',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
