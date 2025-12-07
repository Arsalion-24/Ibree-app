import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/ui/design_system/geometric_shapes.dart';

/// Background with gradient and scattered geometric shapes
/// Used consistently across all screens per client design
class DecoratedBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final int shapesCount;
  final int shapesSeed;
  final bool enableShapes;

  const DecoratedBackground({
    required this.child,
    this.gradient,
    this.shapesCount = 20,
    this.shapesSeed = 0,
    this.enableShapes = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final effectiveGradient = gradient ?? _getThemeGradient(context);

    // Generate shapes based on screen dimensions
    final shapes = enableShapes
        ? GeometricShapesGenerator.generate(
            screenSize: screenSize,
            count: shapesCount,
            seed: shapesSeed,
          )
        : <GeometricShape>[];

    return Container(
      decoration: BoxDecoration(
        gradient: effectiveGradient,
      ),
      child: Stack(
        children: [
          // Geometric shapes layer
          if (enableShapes) GeometricShapesWidget(shapes: shapes),
          // Content layer
          child,
        ],
      ),
    );
  }

  Gradient _getThemeGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      return LinearGradient(
        colors: [
          kdPageBackgroundColor,
          kdBackgroundColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      return kLightBackgroundGradient;
    }
  }
}

/// Localized geometric shapes around a widget (e.g., around buttons or cards)
class LocalGeometricShapes extends StatelessWidget {
  final Widget child;
  final int shapesCount;
  final Size regionSize;
  final int seed;

  const LocalGeometricShapes({
    required this.child,
    this.shapesCount = 8,
    this.regionSize = const Size(300, 200),
    this.seed = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final center = Offset(
          constraints.maxWidth / 2,
          constraints.maxHeight / 2,
        );

        final shapes = GeometricShapesGenerator.generateForRegion(
          center: center,
          regionSize: regionSize,
          count: shapesCount,
          seed: seed,
        );

        return Stack(
          children: [
            Positioned.fill(
              child: GeometricShapesWidget(shapes: shapes),
            ),
            child,
          ],
        );
      },
    );
  }
}
