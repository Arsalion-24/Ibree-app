import 'package:flutter/material.dart';
import 'package:ebeere/commons/widgets/custom_image.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/ui/design_system/room_code_display.dart';
import 'package:ebeere/ui/design_system/geometric_shapes.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Redesigned battle invite card with room code PIN circles
/// Matches client UI specifications
class BattleInviteCard extends StatelessWidget {
  const BattleInviteCard({
    required this.categoryImage,
    required this.categoryName,
    required this.entryFee,
    required this.roomCode,
    required this.shareText,
    this.categoryEnabled = true,
    super.key,
  });

  final String categoryImage;
  final String categoryName;
  final int entryFee;
  final String roomCode;
  final String shareText;
  final bool categoryEnabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.width * UiUtils.hzMarginPct,
      ),
      child: Column(
        children: [
          // ENTRY FEES Header - Purple gradient
          Container(
            decoration: const BoxDecoration(
              gradient: kPurpleCardGradient,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Stack(
              children: [
                // Decorative shapes
                Positioned.fill(
                  child: CustomPaint(
                    painter: GeometricShapesPainter(
                      shapes: [
                        GeometricShape(
                          position: const Offset(30, 15),
                          size: 12,
                          color: Colors.white,
                          type: ShapeType.circleOutline,
                          opacity: 0.3,
                        ),
                        GeometricShape(
                          position: const Offset(80, 25),
                          size: 10,
                          color: Colors.white,
                          type: ShapeType.diamond,
                          opacity: 0.25,
                        ),
                      ],
                    ),
                  ),
                ),
                // Content
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ENTRY FEES | ',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.9),
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      NumberFormat.compact().format(entryFee),
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ROOM CODE Section - White background
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Stack(
              children: [
                // Decorative shapes scattered around
                Positioned.fill(
                  child: CustomPaint(
                    painter: GeometricShapesPainter(
                      shapes: [
                        GeometricShape(
                          position: const Offset(20, 30),
                          size: 12,
                          color: kShapeYellow,
                          type: ShapeType.circle,
                          opacity: 0.6,
                        ),
                        GeometricShape(
                          position: const Offset(60, 80),
                          size: 10,
                          color: klSecondaryColor,
                          type: ShapeType.triangleOutline,
                          opacity: 0.5,
                        ),
                        GeometricShape(
                          position: const Offset(280, 40),
                          size: 14,
                          color: kShapeGreen,
                          type: ShapeType.diamondOutline,
                          opacity: 0.5,
                        ),
                        GeometricShape(
                          position: const Offset(320, 100),
                          size: 8,
                          color: kActionPink,
                          type: ShapeType.circle,
                          opacity: 0.4,
                        ),
                      ],
                    ),
                  ),
                ),
                // Content
                Column(
                  children: [
                    // Room Code with PIN circles
                    RoomCodeDisplay(
                      roomCode: roomCode,
                      label: 'ROOM PIN CODE',
                    ),
                    const SizedBox(height: 24),

                    // Share text
                    Text(
                      shareText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),

                    // Category info (if enabled)
                    if (categoryEnabled) ...[
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: klPrimaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: klPrimaryColor.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: QImage(
                                  imageUrl: categoryImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categoryName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: colorScheme.onTertiary,
                                    ),
                                  ),
                                  Text(
                                    context.tr('quizCategory')!,
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
