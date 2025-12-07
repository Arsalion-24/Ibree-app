import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// "VS" display component for battle screens
/// Shows large "VS" text between two opponents
class VsDisplay extends StatelessWidget {
  final double size;
  final Color color;
  final FontWeight fontWeight;

  const VsDisplay({
    this.size = 48,
    this.color = const Color(0xFF6B5DD3),
    this.fontWeight = FontWeight.w900,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'VS',
      style: GoogleFonts.nunito(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: 2,
      ),
    );
  }
}

/// Vertical VS display with decorative elements
class VsDisplayDecorated extends StatelessWidget {
  final double size;
  final Color color;

  const VsDisplayDecorated({
    this.size = 48,
    this.color = const Color(0xFF6B5DD3),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 2,
          width: 40,
          color: color.withValues(alpha: 0.3),
        ),
        const SizedBox(height: 8),
        Text(
          'VS',
          style: GoogleFonts.nunito(
            fontSize: size,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: 40,
          color: color.withValues(alpha: 0.3),
        ),
      ],
    );
  }
}
