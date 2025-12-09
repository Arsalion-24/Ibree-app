import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/banner_ad_cubit.dart';
import 'package:ebeere/features/ads/widgets/banner_ad_container.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:ebeere/features/quiz/cubits/subcategory_cubit.dart';
import 'package:ebeere/features/quiz/models/category.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/models/subcategory.dart';
import 'package:ebeere/ui/screens/quiz/guess_the_word_quiz_screen.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/ui/widgets/unlock_premium_category_dialog.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 201,
        child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bannerAdLoaded ? 60 : 0),
            child: _buildSubCategory(),
          ),

          /// Banner Ad
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
