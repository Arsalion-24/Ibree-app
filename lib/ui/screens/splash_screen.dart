// AdFormat is deprecated by IronSource and will be removed in SDK 4.0.0.
// Ignoring for now until IronSource provides official migration documentation.
// TODO(J): Update when IronSource SDK 4.0.0 is released with replacement API.
// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/settings/settings_cubit.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/features/system_config/model/ad_type.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/app_tracking_transparency_helper.dart';
import 'package:ebeere/utils/gdpr_helper.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
            body: DecoratedBackground(
              shapesCount: 18,
              shapesSeed: 100,
              child: SizedBox.expand(
                child: Stack(
                children: [
                  /// App Logo
                  Align(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      child: AnimatedBuilder(
                        animation: _logoAnimationController,
                        builder: (_, _) => Transform.scale(
                          scale:
                              _logoScaleUpAnimation.value -
                              _logoScaleDownAnimation.value,
                          child: QImage(
                            imageUrl: _appLogoPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Organization Logo
                  if (showCompanyLogo) ...[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 22),
                        child: QImage(imageUrl: _orgLogoPath),
                      ),
                    ),
                  ],
                ],
              ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QLevelPlayInitListener implements LevelPlayInitListener {
  @override
  void onInitFailed(LevelPlayInitError error) {
    log('LevelPlay init failed: ${error.errorMessage}', name: 'LevelPlay');
  }

  @override
  void onInitSuccess(LevelPlayConfiguration configuration) {
    log('LevelPlay init success', name: 'LevelPlay');
  }
}
