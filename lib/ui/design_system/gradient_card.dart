import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/ui/design_system/geometric_shapes.dart';
import 'package:google_fonts/google_fonts.dart';

/// Purple gradient card for feature sections
/// Used for game modes, rewards, and other feature cards
class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showDecorations;
  final VoidCallback? onTap;

  const GradientCard({
    required this.child,
    this.gradient,
    this.borderRadius = 20,
    this.padding,
    this.margin,
    this.showDecorations = true,
    this.onTap,
    super.key,
  });

  factory GradientCard.purple({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool showDecorations = true,
    VoidCallback? onTap,
  }) {
    return GradientCard(
      gradient: kPurpleCardGradient,
      padding: padding,
      margin: margin,
      showDecorations: showDecorations,
      onTap: onTap,
      child: child,
    );
  }

  factory GradientCard.action({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool showDecorations = true,
    VoidCallback? onTap,
  }) {
    return GradientCard(
      gradient: kActionButtonGradient,
      padding: padding,
      margin: margin,
      showDecorations: showDecorations,
      onTap: onTap,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ?? kPurpleCardGradient;

    Widget cardContent = Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: klPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative shapes
          if (showDecorations) _buildCardDecorations(),
          // Content
          child,
        ],
      ),
    );

    if (onTap != null) {
      cardContent = GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }

  Widget _buildCardDecorations() {
    return Positioned.fill(
      child: CustomPaint(
        painter: GeometricShapesPainter(
          shapes: [
            GeometricShape(
              position: const Offset(30, 20),
              size: 15,
              color: Colors.white,
              type: ShapeType.circleOutline,
              opacity: 0.3,
            ),
            GeometricShape(
              position: const Offset(80, 60),
              size: 12,
              color: Colors.white,
              type: ShapeType.diamond,
              opacity: 0.25,
            ),
            GeometricShape(
              position: const Offset(150, 35),
              size: 10,
              color: Colors.white,
              type: ShapeType.triangleOutline,
              opacity: 0.3,
            ),
            GeometricShape(
              position: const Offset(200, 70),
              size: 8,
              color: Colors.white,
              type: ShapeType.circle,
              opacity: 0.2,
            ),
          ],
        ),
      ),
    );
  }
}

/// Feature card with icon, title, and description
class FeatureCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget icon;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const FeatureCard({
    required this.title,
    this.description,
    required this.icon,
    this.onTap,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradient: gradient ?? kPurpleCardGradient,
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(height: 6),
            Text(
              description!,
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

/// Countdown card for battle starting countdown
class CountdownCard extends StatelessWidget {
  final int seconds;
  final String label;

  const CountdownCard({
    required this.seconds,
    this.label = 'STARTING IN',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            seconds.toString(),
            style: GoogleFonts.nunito(
              fontSize: 72,
              fontWeight: FontWeight.w900,
              color: klPrimaryColor,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
