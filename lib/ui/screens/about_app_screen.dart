import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebeere/commons/widgets/custom_image.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/ui/screens/app_settings_screen.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
<<<<<<< HEAD
=======
import 'package:ebeere/ui/design_system/decorated_background.dart';
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static Route<dynamic> route() {
    return CupertinoPageRoute(builder: (_) => const AboutAppScreen());
  }

  @override
  Widget build(BuildContext context) {
    const options = [
      (title: contactUs, icon: Assets.contactUsIcon),
      (title: aboutUs, icon: Assets.aboutUsIcon),
      (title: termsAndConditions, icon: Assets.termsAndCondIcon),
      (title: privacyPolicy, icon: Assets.privacyPolicyIcon),
    ];

    Future<void> onTapOption(String title) async {
      await context.pushNamed(
        Routes.appSettings,
        arguments: AppSettingsScreenArgs(title),
      );
    }

    return Scaffold(
      appBar: QAppBar(title: Text(context.tr(aboutQuizAppKey)!)),
<<<<<<< HEAD
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.height * UiUtils.vtMarginPct,
          horizontal: context.width * UiUtils.hzMarginPct,
        ),
        child: Column(
=======
      body: DecoratedBackground(
        shapesCount: 14,
        shapesSeed: 876,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.height * UiUtils.vtMarginPct,
            horizontal: context.width * UiUtils.hzMarginPct,
          ),
          child: Column(
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
          spacing: UiUtils.listTileGap,
          children: options
              .map(
                (option) {
                  return ListTile(
                    onTap: () => onTapOption(option.title),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    leading: QImage(
                      imageUrl: option.icon,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      color: context.primaryColor,
                    ),
                    title: Text(
                      context.tr(option.title)!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeights.medium,
                        color: context.primaryTextColor,
                      ),
                    ),
                    tileColor: context.surfaceColor,
                  );
                },
              )
              .toList(growable: false),
<<<<<<< HEAD
=======
          ),
>>>>>>> 8ca00ce (Complete UI Redesign - 100% Implementation)
        ),
      ),
    );
  }
}
