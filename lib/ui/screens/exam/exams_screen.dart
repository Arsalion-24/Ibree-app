import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/banner_ad_cubit.dart';
import 'package:ebeere/features/ads/widgets/banner_ad_container.dart';
import 'package:ebeere/features/exam/cubits/completed_exams_cubit.dart';
import 'package:ebeere/features/exam/cubits/exams_cubit.dart';
import 'package:ebeere/features/exam/exam_repository.dart';
import 'package:ebeere/features/exam/models/exam.dart';
import 'package:ebeere/features/exam/models/exam_result.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/ui/screens/exam/exam_result_screen.dart';
import 'package:ebeere/ui/screens/exam/widgets/exam_key_bottom_sheet_container.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/datetime_utils.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
        body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 700,
        child: Stack(
          children: [
            TabBarView(children: [_buildTodayExams(), _buildExamResults()]),
            if (bannerAdLoaded)
              const Align(
                alignment: Alignment.bottomCenter,
                child: BannerAdContainer(),
              ),
          ],
        ),
      ),
        ),
    );
  }
}
