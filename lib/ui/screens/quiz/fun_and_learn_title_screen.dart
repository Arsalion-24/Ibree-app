import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/banner_ad_cubit.dart';
import 'package:ebeere/features/ads/widgets/banner_ad_container.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/cubits/comprehension_cubit.dart';
import 'package:ebeere/ui/screens/quiz/fun_and_learn_screen.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 209,
        child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bannerAdLoaded ? 60 : 0),
            child: _buildComprehensionList(),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BannerAdContainer(),
          ),
        ],
      ),
        ),
    );
  }
}
