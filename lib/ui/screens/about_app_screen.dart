import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebeere/commons/widgets/custom_image.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/ui/screens/app_settings_screen.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
      body: DecoratedBackground(
        shapesCount: 14,
        shapesSeed: 876,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.height * UiUtils.vtMarginPct,
            horizontal: context.width * UiUtils.hzMarginPct,
          ),
          child: Column(
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
          ),
        ),
      ),
    );
  }
}
