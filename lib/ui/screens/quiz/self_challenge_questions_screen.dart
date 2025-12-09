import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/bookmark/bookmark_repository.dart';
import 'package:ebeere/features/bookmark/cubits/update_bookmark_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/cubits/questions_cubit.dart';
import 'package:ebeere/features/quiz/models/question.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/quiz_repository.dart';
import 'package:ebeere/features/system_config/model/answer_mode.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/ui/widgets/questions_container.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:google_fonts/google_fonts.dart';
        body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 211,
        child: Stack(
          children: [
            BlocConsumer<QuestionsCubit, QuestionsState>(
              bloc: quesCubit,
              listener: (context, state) {
                if (state is QuestionsFetchSuccess) {
                  if (!timerAnimationController.isAnimating) {
                    timerAnimationController.forward();
                  }
                }
              },
              builder: (context, state) {
                if (state is QuestionsFetchInProgress ||
                    state is QuestionsInitial) {
                  return const Center(child: CircularProgressContainer());
                }
                if (state is QuestionsFetchFailure) {
                  return Center(
                    child: ErrorContainer(
                      showBackButton: true,
                      errorMessageColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      errorMessage: convertErrorCodeToLanguageKey(
                        state.errorMessage,
                      ),
                      onTapRetry: _getQuestions,
                      showErrorImage: true,
                    ),
                  );
                }
                final questions = (state as QuestionsFetchSuccess).questions;
                ques = questions;
                return Align(
                  alignment: Alignment.topCenter,
                  child: QuestionsContainer(
                    timerAnimationController: timerAnimationController,
                    quizType: QuizTypes.selfChallenge,
                    answerMode: AnswerMode.noAnswerCorrectness,
                    lifeLines: const {},
                    topPadding:
                        context.height *
                        UiUtils.getQuestionContainerTopPaddingPercentage(
                          context.height,
                        ),
                    hasSubmittedAnswerForCurrentQuestion:
                        hasSubmittedAnswerForCurrentQuestion,
                    questions: questions,
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
                  ),
                );
              },
            ),
            BlocBuilder<QuestionsCubit, QuestionsState>(
              bloc: quesCubit,
              builder: (context, state) {
                if (state is QuestionsFetchSuccess) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildBottomMenu(context),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
        ),
    );
  }
}
