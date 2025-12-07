import 'package:flutter/material.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
<<<<<<< HEAD
=======
import 'package:ebeere/ui/design_system/gradient_card.dart';
import 'package:google_fonts/google_fonts.dart';
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)

class QuizGridCard extends StatelessWidget {
  const QuizGridCard({
    required this.title,
    required this.desc,
    required this.img,
    super.key,
    this.onTap,
    this.iconOnRight = true,
  });

  final String title;
  final String desc;
  final String img;
  final bool iconOnRight;
  final void Function()? onTap;

<<<<<<< HEAD
  ///
  static const _borderRadius = 10.0;
  static const _padding = EdgeInsets.all(12);
  static const _iconBorderRadius = 6.0;
  static const _iconMargin = EdgeInsets.all(5);

  static const _boxShadow = [
    BoxShadow(
      offset: Offset(0, 50),
      blurRadius: 30,
      spreadRadius: 5,
      color: Color(0xff45536d),
    ),
  ];

=======
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (_, constraints) {
          final cSize = constraints.maxWidth;
<<<<<<< HEAD
          final iconSize = cSize * .28;
          final iconColor = context.primaryColor;

          return Stack(
            children: [
              /// Box Shadow
              Positioned(
                top: 0,
                left: cSize * 0.2,
                right: cSize * 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: _boxShadow,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(cSize * .525),
                    ),
                  ),
                  width: cSize,
                  height: cSize * .6,
                ),
              ),

              /// Card
              Container(
                width: cSize,
                height: cSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  color: context.surfaceColor,
                ),
                padding: _padding,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: .stretch,
                      mainAxisSize: .min,
                      children: [
                        /// Title
                        Text(
                          title,
                          maxLines: 2,
                          overflow: .ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeights.semiBold,
                            fontSize: 18,
                            color: context.primaryTextColor,
                          ),
                        ),

                        /// Description
                        Expanded(
                          child: Text(
                            desc,
                            maxLines: 2,
                            overflow: .ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeights.regular,
                              color: context.primaryTextColor.withValues(
                                alpha: .6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Svg Icon
                    Align(
                      alignment: iconOnRight ? .bottomRight : .bottomLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            _iconBorderRadius,
                          ),
                          border: Border.all(
                            color: context.scaffoldBackgroundColor,
                          ),
                        ),
                        padding: _iconMargin,
                        width: iconSize,
                        height: iconSize,
                        child: QImage(
                          imageUrl: img,
                          color: iconColor,
                          fit: .contain,
=======
          final iconSize = cSize * .35;

          return GradientCard.purple(
            showDecorations: true,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Expanded(
                      child: Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.3,
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
                        ),
                      ),
                    ),
                  ],
                ),
<<<<<<< HEAD
              ),
            ],
=======

                // Icon
                Positioned(
                  bottom: 0,
                  right: iconOnRight ? 0 : null,
                  left: iconOnRight ? null : 0,
                  child: Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: QImage(
                      imageUrl: img,
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
          );
        },
      ),
    );
  }
}
