import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/rewarded_ad_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/features/quiz/cubits/questions_cubit.dart';
import 'package:ebeere/features/quiz/cubits/subcategory_cubit.dart';
import 'package:ebeere/features/quiz/cubits/unlocked_level_cubit.dart';
import 'package:ebeere/features/quiz/models/comprehension.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/quiz_repository.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/screens/quiz/widgets/audio_question_container.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/ui/widgets/questions_container.dart';
import 'package:ebeere/ui/widgets/text_circular_timer.dart';
import 'package:ebeere/ui/widgets/watch_reward_ad_dialog.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
              body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 200,
        child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: QuestionsContainer(
                      audioQuestionContainerKeys: audioQuestionContainerKeys,
                      quizType: widget.quizType,
                      answerMode: context.read<SystemConfigCubit>().answerMode,
                      lifeLines: getLifeLines(),
                      timerAnimationController: timerAnimationController,
                      topPadding:
                          context.height *
                          UiUtils.getQuestionContainerTopPaddingPercentage(
                            context.height,
                          ),
                      hasSubmittedAnswerForCurrentQuestion:
                          hasSubmittedAnswerForCurrentQuestion,
                      questions: context.read<QuestionsCubit>().questions(),
                      submitAnswer: submitAnswer,
                      questionContentAnimation: questionContentAnimation,
                      questionScaleDownAnimation: questionScaleDownAnimation,
                      questionScaleUpAnimation: questionScaleUpAnimation,
                      questionSlideAnimation: questionSlideAnimation,
                      currentQuestionIndex: currentQuestionIndex,
                      questionAnimationController: questionAnimationController,
                      questionContentAnimationController:
                          questionContentAnimationController,
                      guessTheWordQuestions: const [],
                      guessTheWordQuestionContainerKeys: const [],
                      level: widget.level,
                    ),
                  ),
                  _buildLifeLines(),
                  _buildShowOptionButton(),
                ],
              ),
            ),
          );
        },
      ),
        ),
    );
  }
}
