import 'package:flutter/material.dart';

/// Animation utilities and presets for UI transitions
class AppAnimations {
  // Durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  // Curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bouncy = Curves.elasticOut;
  static const Curve smooth = Curves.easeOutCubic;

  /// Card slide in from bottom
  static Animation<Offset> slideInFromBottom(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: smooth,
    ));
  }

  /// Card slide in from right
  static Animation<Offset> slideInFromRight(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: smooth,
    ));
  }

  /// Fade in animation
  static Animation<double> fadeIn(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: defaultCurve),
    );
  }

  /// Scale animation (for buttons, cards)
  static Animation<double> scale(
    AnimationController controller, {
    double begin = 0.8,
    double end = 1.0,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: bouncy),
    );
  }

  /// Staggered animation for list items
  static Animation<double> staggeredFadeIn(
    AnimationController controller,
    int index,
    int total,
  ) {
    final start = (index / total) * 0.5;
    final end = start + 0.5;

    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: defaultCurve),
      ),
    );
  }

  /// Staggered slide animation for list items
  static Animation<Offset> staggeredSlideIn(
    AnimationController controller,
    int index,
    int total,
  ) {
    final start = (index / total) * 0.5;
    final end = start + 0.5;

    return Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: smooth),
      ),
    );
  }

  /// Pulse animation (for attention grabbing)
  static Animation<double> pulse(AnimationController controller) {
    return TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
    ]).animate(controller);
  }

  /// Shake animation (for errors)
  static Animation<double> shake(AnimationController controller) {
    return TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  /// Success animation (for correct answers)
  static Animation<double> successScale(AnimationController controller) {
    return TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: bouncy));
  }

  /// Progress animation
  static Animation<double> progress(
    AnimationController controller,
    double target,
  ) {
    return Tween<double>(begin: 0.0, end: target).animate(
      CurvedAnimation(parent: controller, curve: smooth),
    );
  }
}

/// Animated geometric shapes that float/move
class FloatingShapesAnimation extends StatefulWidget {
  final Widget child;
  final bool enable;

  const FloatingShapesAnimation({
    required this.child,
    this.enable = true,
    super.key,
  });

  @override
  State<FloatingShapesAnimation> createState() =>
      _FloatingShapesAnimationState();
}

class _FloatingShapesAnimationState extends State<FloatingShapesAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    if (widget.enable) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enable) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _controller.value * 10 - 5),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Page transition builder
class AppPageTransition {
  static PageRouteBuilder fadeTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: AppAnimations.normal,
    );
  }

  static PageRouteBuilder slideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      transitionDuration: AppAnimations.normal,
    );
  }

  static PageRouteBuilder scaleTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: AppAnimations.smooth),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      transitionDuration: AppAnimations.normal,
    );
  }
}
