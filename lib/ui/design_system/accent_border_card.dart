import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';

/// Card with left-side colored border accent
/// Used for question cards, answer options, and feature cards
class AccentBorderCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final VoidCallback? onTap;
  final bool showShadow;

  const AccentBorderCard({
    required this.child,
    required this.borderColor,
    this.borderWidth = 4,
    this.backgroundColor,
    this.borderRadius = 12,
    this.padding,
    this.margin,
    this.elevation,
    this.onTap,
    this.showShadow = true,
    super.key,
  });

  /// Question card with red left border
  factory AccentBorderCard.question({
    required Widget child,
    Color borderColor = kQuestionBorderRed,
    double borderWidth = 5,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return AccentBorderCard(
      borderColor: borderColor,
      borderWidth: borderWidth,
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      child: child,
    );
  }

  /// Answer option card with gray left border (changes to green/red)
  factory AccentBorderCard.answer({
    required Widget child,
    Color borderColor = kAnswerBorderGray,
    double borderWidth = 4,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
  }) {
    return AccentBorderCard(
      borderColor: borderColor,
      borderWidth: borderWidth,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: margin,
      onTap: onTap,
      child: child,
    );
  }

  /// Feature card with custom border
  factory AccentBorderCard.feature({
    required Widget child,
    Color borderColor = klPrimaryColor,
    double borderWidth = 4,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
  }) {
    return AccentBorderCard(
      borderColor: borderColor,
      borderWidth: borderWidth,
      backgroundColor: backgroundColor,
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      onTap: onTap,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.surface;

    Widget cardContent = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border(
          left: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      );
    }

    return cardContent;
  }
}

/// Vertical card with top colored border accent (alternative style)
class TopAccentBorderCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const TopAccentBorderCard({
    required this.child,
    required this.borderColor,
    this.borderWidth = 4,
    this.backgroundColor,
    this.borderRadius = 12,
    this.padding,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.surface;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
