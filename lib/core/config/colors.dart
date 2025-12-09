import 'package:flutter/material.dart';

/// Light Theme
const klBackgroundColor = Color(0xffffffff);
const klCanvasColor = Color(0xcc000000);
const klPageBackgroundColor = Color(0xfff5f8fb);
const klPrimaryColor = Color(0xff6B5DD3);
const klSecondaryColor = Color(0xff1ECDDA);
const klPrimaryTextColor = Color(0xff2D3748);

/// Dark Theme
const kdBackgroundColor = Color(0xff1A202C);
const kdCanvasColor = Color(0xccffffff);
const kdPageBackgroundColor = Color(0xff2D3748);
const kdPrimaryColor = Color(0xff8B7DE8);
const kdSecondaryColor = Color(0xff3DE0ED);
const kdPrimaryTextColor = Color(0xffffffff);

/// Common
const Color kAddCoinColor = Color(0xFF5DB760);
const Color kBadgeLockedColor = Colors.grey;
const Color kHurryUpTimerColor = Color(0xFFFF6169);
const Color kCorrectAnswerColor = Color(0xFF5DB760);
const Color kWrongAnswerColor = Color(0xFFFF6169);
const Color kPendingColor = Colors.orangeAccent;

/// Action Buttons
const Color kActionRed = Color(0xFFE63946);
const Color kActionPink = Color(0xFFF1495D);

/// Decorative Shapes
const Color kShapeYellow = Color(0xFFFFC857);
const Color kShapeGreen = Color(0xFF95E1D3);
const Color kShapeLightPurple = Color(0xFF8B7DE8);
const Color kShapeBlue = Color(0xFF4A90E2);

/// Border Accents
const Color kQuestionBorderRed = Color(0xFFE63946);
const Color kAnswerBorderGray = Color(0xFFA0AEC0);
const Color kPlayerBorderYellow = Color(0xFFFFD700);
const Color kPlayerBorderPink = Color(0xFFF1495D);

/// Gradients
const kPrimaryGradient = LinearGradient(
  colors: [klPrimaryColor, klSecondaryColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kDarkPrimaryGradient = LinearGradient(
  colors: [kdPrimaryColor, kdSecondaryColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kLightBackgroundGradient = LinearGradient(
  colors: [Color(0xFFFFFFFF), Color(0xFFF0F4FF)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const kActionButtonGradient = LinearGradient(
  colors: [kActionRed, kActionPink],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const kPurpleCardGradient = LinearGradient(
  colors: [klPrimaryColor, kShapeLightPurple],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kPurpleDarkCardGradient = LinearGradient(
  colors: [Color(0xFF5B4DC3), Color(0xFF7B6DD8)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
