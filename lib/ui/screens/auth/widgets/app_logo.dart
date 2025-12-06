import 'package:flutter/material.dart';
import 'package:ebeere/commons/commons.dart' show QImage;
import 'package:ebeere/core/constants/assets_constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const QImage(imageUrl: Assets.appLogo);
  }
}
