import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/bookmark/bookmark_repository.dart';
import 'package:ebeere/features/bookmark/cubits/audio_question_bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/guess_the_word_bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/update_bookmark_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/cubits/guess_the_word_quiz_cubit.dart';
import 'package:ebeere/features/quiz/cubits/questions_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/quiz_repository.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/features/system_config/model/answer_mode.dart';
import 'package:ebeere/ui/screens/quiz/widgets/audio_question_container.dart';
import 'package:ebeere/ui/screens/quiz/widgets/guess_the_word_question_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/ui/widgets/questions_container.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
        body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 207,
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: completedQuiz
                  ? Align(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${context.tr("completeAllQueLbl")!} (:",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontSize: 18,
                              fontWeight: FontWeights.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.3,
                            ),
                            child: CustomRoundedButton(
                              widthPercentage: context.width * 0.3,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.surface,
                              buttonTitle: context.tr('goBAckLbl'),
                              titleColor: Theme.of(context).primaryColor,
                              radius: 5,
                              showBorder: false,
                              elevation: 5,
                              onTap: () {
                                if (isSettingDialogOpen) {
                                  Navigator.of(context).pop();
                                }
                                if (isExitDialogOpen) {
                                  Navigator.of(context).pop();
                                }

                                Navigator.of(context).pop();
                              },
                              height: 35,
                            ),
                          ),
                        ],
                      ),
                    )
                  : _buildQuestions(),
            ),
            if (!completedQuiz)
              _buildBottomButton()
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
        ),
    );
  }
}
