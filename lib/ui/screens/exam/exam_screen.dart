import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/exam/cubits/exam_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/features/system_config/model/answer_mode.dart';
import 'package:ebeere/ui/screens/exam/widgets/exam_question_status_bottom_sheet_container.dart';
import 'package:ebeere/ui/screens/exam/widgets/exam_timer_container.dart';
import 'package:ebeere/ui/screens/quiz/widgets/question_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/latex_answer_options_list.dart';
import 'package:ebeere/ui/widgets/option_container.dart';
import 'package:ebeere/utils/answer_encryption.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
        body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 701,
        child: Stack(
          children: [
            _buildQuestions(),
            Align(alignment: Alignment.bottomCenter, child: _buildBottomMenu()),
            _buildYouLeftTheExam(),
            if (isScreenRecordingInIos)
              SizedBox(
                width: context.width,
                height: context.height,
                child: const ColoredBox(color: Colors.black),
              ),
          ],
        ),
      ),
        ),
    );
  }

  void onTapBackButton() {
    isExitDialogOpen = true;
    context
        .showDialog<void>(
          title: context.tr('quizExitTitle'),
          message: context.tr('quizExitLbl'),
          cancelButtonText: context.tr('leaveAnyways'),
          confirmButtonText: context.tr('keepPlaying'),
          onCancel: () {
            submitResult();
            context
              ..shouldPop()
              ..shouldPop();
          },
        )
        .then((_) => isExitDialogOpen = false);
  }
}
