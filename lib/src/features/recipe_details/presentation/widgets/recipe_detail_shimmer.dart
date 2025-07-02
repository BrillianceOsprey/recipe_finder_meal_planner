import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailShimmer extends StatelessWidget {
  const RecipeDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              stretch: true,
              backgroundColor: Colors.green[700],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.grey[300],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rect(height: 28, width: 220),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _circle(radius: 18),
                        const SizedBox(width: 12),
                        _rect(height: 16, width: 80),
                        const SizedBox(width: 20),
                        _circle(radius: 18),
                        const SizedBox(width: 12),
                        _rect(height: 16, width: 80),
                      ],
                    ),
                    const SizedBox(height: 26),
                    _rect(height: 18, width: 120),
                    const SizedBox(height: 8),
                    ...List.generate(
                        4,
                        (i) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: _rect(height: 18, width: double.infinity),
                            )),
                    const SizedBox(height: 28),
                    _rect(height: 18, width: 120),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children:
                          List.generate(6, (_) => _rect(height: 24, width: 80)),
                    ),
                    const SizedBox(height: 28),
                    _rect(height: 18, width: 120),
                    const SizedBox(height: 12),
                    ...List.generate(
                        5,
                        (i) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  _circle(radius: 16),
                                  const SizedBox(width: 12),
                                  _rect(height: 16, width: 240),
                                ],
                              ),
                            )),
                    const SizedBox(height: 24),
                    _rect(height: 18, width: 120),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children:
                          List.generate(6, (_) => _rect(height: 24, width: 80)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rect({double height = 18, double width = 80}) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      );

  Widget _circle({double radius = 16}) => Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
}
