import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Current coins display with decorative elements
/// Used on home screen and throughout the app
class CoinDisplay extends StatelessWidget {
  final int coins;
  final bool showLabel;
  final double fontSize;
  final VoidCallback? onTap;

  const CoinDisplay({
    required this.coins,
    this.showLabel = true,
    this.fontSize = 32,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLabel) ...[
              Text(
                'Current Coins',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.monetization_on,
                  color: kShapeYellow,
                  size: fontSize * 0.8,
                ),
                const SizedBox(width: 8),
                Text(
                  coins.toString(),
                  style: GoogleFonts.nunito(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    color: klPrimaryTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact coin display for headers/toolbars
class CompactCoinDisplay extends StatelessWidget {
  final int coins;
  final VoidCallback? onTap;

  const CompactCoinDisplay({
    required this.coins,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: kShapeYellow.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: kShapeYellow,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.monetization_on,
              color: kShapeYellow,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              coins.toString(),
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: klPrimaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
