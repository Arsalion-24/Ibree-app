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
