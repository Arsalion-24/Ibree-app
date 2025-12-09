import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/settings/settings_cubit.dart';
            DecoratedBackground(
              shapesCount: 15,
              child: Container(
                height: context.height * 0.75,
                width: context.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: _buildIntroSlider(),
              ),
            ),
            Container(
              width: context.width,
              margin: EdgeInsets.only(top: context.shortestSide * 0.12),
              padding: EdgeInsets.symmetric(
                horizontal: context.width * UiUtils.hzMarginPct,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPageIndicatorNew(),
                  AnimatedBuilder(
                    builder: (context, child) => Transform.scale(
                      scale: buttonSqueezeAnimation.value,
                      child: child,
                    ),
                    animation: buttonController,
                    child: InkWell(
                      onTap: () {
                        context.read<SettingsCubit>().changeShowIntroSlider();
                        context.pushReplacementNamed(Routes.home);
                      },
                      child: Text(
                        context.tr('skip')!,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeights.regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: context.height * 0.10),
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.15),
                child: PillButton(
                  text: context.tr('getStarted')!,
                  style: PillButtonStyle.white,
                  onPressed: () {
                    context.read<SettingsCubit>().changeShowIntroSlider();
                    context.pushReplacementNamed(Routes.home);
                  },
                  height: 50,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
