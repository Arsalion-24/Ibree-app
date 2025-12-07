import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:ebeere/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

=======
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/ui/design_system/pill_button.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom rounded button - updated to pill shape for new design
/// Maintains backward compatibility with legacy API
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    required this.widthPercentage,
    required this.backgroundColor,
    required this.buttonTitle,
    required this.radius,
    required this.showBorder,
    required this.height,
    super.key,
    this.borderColor,
    this.elevation,
    this.onTap,
    this.shadowColor,
    this.titleColor,
    this.fontWeight,
    this.textSize,
<<<<<<< HEAD
=======
    this.usePillStyle = true, // NEW: defaults to pill-shaped design
    this.icon,
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
  });

  final String? buttonTitle;
  final double height;
  final double widthPercentage;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final double radius;
  final Color? shadowColor;
  final bool showBorder;
  final Color? borderColor;
  final Color? titleColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final double? elevation;
<<<<<<< HEAD

  @override
  Widget build(BuildContext context) {
=======
  final bool usePillStyle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    // Use new pill-shaped design by default
    if (usePillStyle) {
      return _buildPillButton(context);
    }

    // Legacy design (for backward compatibility)
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
    return Material(
      shadowColor: shadowColor ?? Colors.black54,
      elevation: elevation ?? 0.0,
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
<<<<<<< HEAD
          //
=======
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
          alignment: Alignment.center,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: showBorder
                ? Border.all(
                    color:
                        borderColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                  )
                : null,
          ),
          width: context.width * widthPercentage,
          child: Text(
            '$buttonTitle',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                fontSize: textSize ?? 16.0,
                color: titleColor ?? Theme.of(context).scaffoldBackgroundColor,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  Widget _buildPillButton(BuildContext context) {
    // Determine button style based on background color
    PillButtonStyle style;
    if (_isActionColor(backgroundColor)) {
      style = PillButtonStyle.primary;
    } else if (_isPurpleColor(backgroundColor)) {
      style = PillButtonStyle.purple;
    } else if (showBorder) {
      style = PillButtonStyle.secondary;
    } else {
      style = PillButtonStyle.white;
    }

    return SizedBox(
      width: context.width * widthPercentage,
      child: PillButton(
        text: buttonTitle ?? '',
        onPressed: onTap,
        style: style,
        icon: icon,
        height: height,
        fontSize: textSize ?? 18,
      ),
    );
  }

  bool _isActionColor(Color color) {
    return color == kActionRed || 
           color == kActionPink ||
           color.value == kActionRed.value;
  }

  bool _isPurpleColor(Color color) {
    return color == klPrimaryColor || 
           color.value == klPrimaryColor.value;
  }
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
}
