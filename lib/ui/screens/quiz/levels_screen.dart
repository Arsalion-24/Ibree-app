import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/widgets/custom_snackbar.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/banner_ad_cubit.dart';
import 'package:ebeere/features/ads/widgets/banner_ad_container.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:ebeere/features/quiz/cubits/unlocked_level_cubit.dart';
import 'package:ebeere/features/quiz/models/category.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
      body: DecoratedBackground(
        shapesCount: 18,
        shapesSeed: 666,
        child: Stack(
        children: [
          ///
          Padding(
            padding: EdgeInsets.only(bottom: bannerAdLoaded ? 60 : 0),
            child: SingleChildScrollView(child: _buildLevels()),
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
