import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/ui/design_system/geometric_shapes.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pill-shaped button with optional decorative shapes
/// Primary style: Red/pink gradient with white shapes
/// Secondary style: Purple outline with transparent background
class PillButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final PillButtonStyle style;
  final Widget? icon;
  final bool showDecorations;
  final double? width;
  final double height;
  final bool isLoading;
  final double fontSize;

  const PillButton({
    required this.text,
    this.onPressed,
    this.style = PillButtonStyle.primary,
    this.icon,
    this.showDecorations = true,
    this.width,
    this.height = 56,
    this.isLoading = false,
    this.fontSize = 18,
    super.key,
  });

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? (_) => _controller.forward() : null,
      onTapUp: widget.onPressed != null ? (_) => _controller.reverse() : null,
      onTapCancel: widget.onPressed != null ? () => _controller.reverse() : null,
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: _getDecoration(),
          child: Stack(
            children: [
              // Decorative shapes inside button
              if (widget.showDecorations && widget.style == PillButtonStyle.primary)
                _buildDecorativeShapes(),
              // Button content
              Center(
                child: widget.isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getTextColor(),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            widget.icon!,
                            const SizedBox(width: 8),
                          ],
                          Text(
                            widget.text,
                            style: GoogleFonts.nunito(
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w700,
                              color: _getTextColor(),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (widget.style) {
      case PillButtonStyle.primary:
        return BoxDecoration(
          gradient: kActionButtonGradient,
          borderRadius: BorderRadius.circular(widget.height / 2),
          boxShadow: [
            BoxShadow(
              color: kActionRed.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );

      case PillButtonStyle.secondary:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: klPrimaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(widget.height / 2),
        );

      case PillButtonStyle.purple:
        return BoxDecoration(
          gradient: kPrimaryGradient,
          borderRadius: BorderRadius.circular(widget.height / 2),
          boxShadow: [
            BoxShadow(
              color: klPrimaryColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );

      case PillButtonStyle.white:
        return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.height / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
    }
  }

  Color _getTextColor() {
    switch (widget.style) {
      case PillButtonStyle.primary:
      case PillButtonStyle.purple:
        return Colors.white;
      case PillButtonStyle.secondary:
        return klPrimaryColor;
      case PillButtonStyle.white:
        return klPrimaryTextColor;
    }
  }

  Widget _buildDecorativeShapes() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ButtonShapesPainter(
          shapes: [
            GeometricShape(
              position: const Offset(30, 15),
              size: 12,
              color: Colors.white,
              type: ShapeType.diamond,
              opacity: 0.6,
            ),
            GeometricShape(
              position: const Offset(60, 40),
              size: 8,
              color: Colors.white,
              type: ShapeType.circle,
              opacity: 0.5,
            ),
            GeometricShape(
              position: const Offset(90, 20),
              size: 10,
              color: Colors.white,
              type: ShapeType.triangleOutline,
              opacity: 0.4,
            ),
          ],
        ),
      ),
    );
  }
}

enum PillButtonStyle {
  primary, // Red/pink gradient
  secondary, // Purple outline
  purple, // Purple gradient
  white, // White background
}

class _ButtonShapesPainter extends CustomPainter {
  final List<GeometricShape> shapes;

  const _ButtonShapesPainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    for (final shape in shapes) {
      // Only paint if within bounds
      if (shape.position.dx < size.width &&
          shape.position.dy < size.height) {
        final paint = Paint()
          ..color = shape.color.withValues(alpha: shape.opacity)
          ..style = shape.type.name.contains('Outline')
              ? PaintingStyle.stroke
              : PaintingStyle.fill
          ..strokeWidth = 1.5;

        canvas.save();
        canvas.translate(shape.position.dx, shape.position.dy);
        canvas.rotate(shape.rotation);

        switch (shape.type) {
          case ShapeType.circle:
          case ShapeType.circleOutline:
            canvas.drawCircle(Offset.zero, shape.size / 2, paint);
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
  }

  @override
  bool shouldRepaint(_ButtonShapesPainter oldDelegate) => false;
}

/// Small pill button for secondary actions
class SmallPillButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;

  const SmallPillButton({
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: color ?? klPrimaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
