import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/battle_room/battle_room_repository.dart';
import 'package:ebeere/features/battle_room/cubits/battle_room_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/message_cubit.dart';
import 'package:ebeere/features/battle_room/models/message.dart';
import 'package:ebeere/features/bookmark/bookmark_repository.dart';
import 'package:ebeere/features/bookmark/cubits/update_bookmark_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/features/quiz/cubits/set_coin_score_cubit.dart';
import 'package:ebeere/features/quiz/models/question.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
        body: DecoratedBackground(
          shapesCount: 22,
          shapesSeed: 321,
          child: MultiBlocListener(
          listeners: [
            BlocListener<BattleRoomCubit, BattleRoomState>(
              bloc: battleRoomCubit,
              listener: (context, state) {
                battleRoomListener(context, state, battleRoomCubit);
              },
            ),
            BlocListener<MessageCubit, MessageState>(
              bloc: context.read<MessageCubit>(),
              listener: (context, state) {
                //this listener will be call everytime when new message will add
                messagesListener(state);
              },
            ),
            BlocListener<UpdateCoinsCubit, UpdateCoinsState>(
              listener: (context, state) {
                if (state is UpdateCoinsFailure) {
                  if (state.errorMessage == errorCodeUnauthorizedAccess) {
                    timerAnimationController.stop();
                    opponentUserTimerAnimationController.stop();
                    showAlreadyLoggedInDialog(context);
                  }
                }
              },
            ),
          ],
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: BlocBuilder<BattleRoomCubit, BattleRoomState>(
                  bloc: battleRoomCubit,
                  builder: (context, state) {
                    return QuestionsContainer(
                      topPadding:
                          context.height *
                          UiUtils.getQuestionContainerTopPaddingPercentage(
                            context.height,
                          ),
                      timerAnimationController: timerAnimationController,
                      quizType: QuizTypes.oneVsOneBattle,
                      answerMode: context.read<SystemConfigCubit>().answerMode,
                      lifeLines: const {},
                      guessTheWordQuestionContainerKeys: const [],
                      guessTheWordQuestions: const [],
                      hasSubmittedAnswerForCurrentQuestion:
                          hasSubmittedAnswerForCurrentQuestion,
                      questions: battleRoomCubit.getQuestions(),
                      submitAnswer: submitAnswer,
                      questionContentAnimation: questionContentAnimation,
                      questionScaleDownAnimation: questionScaleDownAnimation,
                      questionScaleUpAnimation: questionScaleUpAnimation,
                      questionSlideAnimation: questionSlideAnimation,
                      currentQuestionIndex: currentQuestionIndex,
                      questionAnimationController: questionAnimationController,
                      questionContentAnimationController:
                          questionContentAnimationController,
                    );
                  },
                ),
              ),
              _buildMessageBoxContainer(),
              _buildCurrentUserDetailsContainer(),
              _buildCurrentUserMessageContainer(),
              _buildOpponentUserDetailsContainer(),
              _buildOpponentUserMessageContainer(),
              _buildYouWonGameDialog(),
              _buildCurrentUserLeftTheGame(),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
