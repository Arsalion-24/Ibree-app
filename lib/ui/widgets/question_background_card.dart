import 'package:flutter/material.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/utils/extensions.dart';

/// Question card with left-side RED border accent
/// Redesigned to match client UI specifications
class QuestionBackgroundCard extends StatelessWidget {
  const QuestionBackgroundCard({
    required this.opacity,
    required this.heightPercentage,
    required this.topMarginPercentage,
    required this.widthPercentage,
    this.borderColor = kQuestionBorderRed,
    super.key,
  });
  
  final double opacity;
  final double widthPercentage;
  final double topMarginPercentage;
  final double heightPercentage;
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
        ),
      ),
    );
  }
}
