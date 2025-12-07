import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:ebeere/utils/extensions.dart';

=======
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/utils/extensions.dart';

/// Question card with left-side RED border accent
/// Redesigned to match client UI specifications
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
class QuestionBackgroundCard extends StatelessWidget {
  const QuestionBackgroundCard({
    required this.opacity,
    required this.heightPercentage,
    required this.topMarginPercentage,
    required this.widthPercentage,
<<<<<<< HEAD
    super.key,
  });
=======
    this.borderColor = kQuestionBorderRed,
    super.key,
  });
  
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
  final double opacity;
  final double widthPercentage;
  final double topMarginPercentage;
  final double heightPercentage;
<<<<<<< HEAD
=======
  final Color borderColor;
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: EdgeInsets.only(top: context.height * topMarginPercentage),
        width: context.width * widthPercentage,
        height: context.height * heightPercentage,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
<<<<<<< HEAD
          borderRadius: BorderRadius.circular(25),
=======
          borderRadius: BorderRadius.circular(16),
          // LEFT-SIDE RED BORDER - KEY DESIGN ELEMENT
          border: Border(
            left: BorderSide(
              color: borderColor,
              width: 5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
        ),
      ),
    );
  }
}
