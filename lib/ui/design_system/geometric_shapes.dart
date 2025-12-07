import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';

/// Geometric shapes system for decorative backgrounds
class GeometricShape {
  final Offset position;
  final double size;
  final Color color;
  final ShapeType type;
  final double rotation;
  final double opacity;

  const GeometricShape({
    required this.position,
    required this.size,
    required this.color,
    required this.type,
    this.rotation = 0,
    this.opacity = 1.0,
  });
}

enum ShapeType {
  circle,
  circleOutline,
  triangle,
  triangleOutline,
  diamond,
  diamondOutline,
  square,
  squareOutline,
}

/// Generates random geometric shapes for background decoration
class GeometricShapesGenerator {
  static List<GeometricShape> generate({
    required Size screenSize,
    int count = 20,
    int seed = 0,
  }) {
    final random = Random(seed);
    final shapes = <GeometricShape>[];

    final colors = [
      kShapeYellow,
      kShapeGreen,
      klSecondaryColor,
      kShapeLightPurple,
      klPrimaryColor.withValues(alpha: 0.3),
      kActionPink.withValues(alpha: 0.3),
    ];

    final shapeTypes = ShapeType.values;

    for (var i = 0; i < count; i++) {
      final x = random.nextDouble() * screenSize.width;
      final y = random.nextDouble() * screenSize.height;
      final size = 10 + random.nextDouble() * 30; // 10-40px
      final color = colors[random.nextInt(colors.length)];
      final type = shapeTypes[random.nextInt(shapeTypes.length)];
      final rotation = random.nextDouble() * pi * 2;
      final opacity = 0.3 + random.nextDouble() * 0.5; // 0.3-0.8

      shapes.add(
        GeometricShape(
          position: Offset(x, y),
          size: size,
          color: color,
          type: type,
          rotation: rotation,
          opacity: opacity,
        ),
      );
    }

    return shapes;
  }

  /// Generate shapes for a specific region (e.g., around a card)
  static List<GeometricShape> generateForRegion({
    required Offset center,
    required Size regionSize,
    int count = 10,
    int seed = 0,
  }) {
    final random = Random(seed);
    final shapes = <GeometricShape>[];

    final colors = [
      kShapeYellow,
      kShapeGreen,
      klSecondaryColor,
      kShapeLightPurple,
    ];

    final shapeTypes = ShapeType.values;

    for (var i = 0; i < count; i++) {
      final x = center.dx - regionSize.width / 2 +
          random.nextDouble() * regionSize.width;
      final y = center.dy - regionSize.height / 2 +
          random.nextDouble() * regionSize.height;
      final size = 8 + random.nextDouble() * 20; // 8-28px
      final color = colors[random.nextInt(colors.length)];
      final type = shapeTypes[random.nextInt(shapeTypes.length)];
      final rotation = random.nextDouble() * pi * 2;
      final opacity = 0.4 + random.nextDouble() * 0.4; // 0.4-0.8

      shapes.add(
        GeometricShape(
          position: Offset(x, y),
          size: size,
          color: color,
          type: type,
          rotation: rotation,
          opacity: opacity,
        ),
      );
    }

    return shapes;
  }
}

/// Custom painter for geometric shapes
class GeometricShapesPainter extends CustomPainter {
  final List<GeometricShape> shapes;

  const GeometricShapesPainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    for (final shape in shapes) {
      final paint = Paint()
        ..color = shape.color.withValues(alpha: shape.opacity)
        ..style = shape.type.name.contains('Outline')
            ? PaintingStyle.stroke
            : PaintingStyle.fill
        ..strokeWidth = 2;

      canvas.save();
      canvas.translate(shape.position.dx, shape.position.dy);
      canvas.rotate(shape.rotation);

      switch (shape.type) {
        case ShapeType.circle:
        case ShapeType.circleOutline:
          canvas.drawCircle(
            Offset.zero,
            shape.size / 2,
            paint,
          );
          break;

        case ShapeType.triangle:
        case ShapeType.triangleOutline:
          final path = Path();
          path.moveTo(0, -shape.size / 2);
          path.lineTo(shape.size / 2, shape.size / 2);
          path.lineTo(-shape.size / 2, shape.size / 2);
          path.close();
          canvas.drawPath(path, paint);
          break;

        case ShapeType.diamond:
        case ShapeType.diamondOutline:
          final path = Path();
          path.moveTo(0, -shape.size / 2);
          path.lineTo(shape.size / 2, 0);
          path.lineTo(0, shape.size / 2);
          path.lineTo(-shape.size / 2, 0);
          path.close();
          canvas.drawPath(path, paint);
          break;

        case ShapeType.square:
        case ShapeType.squareOutline:
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: shape.size,
              height: shape.size,
            ),
            paint,
          );
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(GeometricShapesPainter oldDelegate) {
    return oldDelegate.shapes != shapes;
  }
}

/// Widget that displays geometric shapes
class GeometricShapesWidget extends StatelessWidget {
  final List<GeometricShape> shapes;

  const GeometricShapesWidget({
    required this.shapes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GeometricShapesPainter(shapes: shapes),
      child: const SizedBox.expand(),
    );
  }
}
