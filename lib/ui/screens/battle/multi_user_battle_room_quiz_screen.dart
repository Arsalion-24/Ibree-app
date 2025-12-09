import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/battle_room/battle_room_repository.dart';
import 'package:ebeere/features/battle_room/cubits/message_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/multi_user_battle_room_cubit.dart';
import 'package:ebeere/features/battle_room/models/battle_room.dart';
import 'package:ebeere/features/battle_room/models/message.dart';
import 'package:ebeere/features/bookmark/bookmark_repository.dart';
import 'package:ebeere/features/bookmark/cubits/update_bookmark_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/features/quiz/cubits/set_coin_score_cubit.dart';
import 'package:ebeere/features/quiz/models/question.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/models/user_battle_room_details.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/screens/battle/multi_user_battle_room_result_screen.dart';
import 'package:ebeere/ui/screens/battle/widgets/message_box_container.dart';
import 'package:ebeere/ui/screens/battle/widgets/message_container.dart';
import 'package:ebeere/ui/screens/battle/widgets/rectangle_user_profile_container.dart';
import 'package:ebeere/ui/screens/battle/widgets/wait_for_others_container.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/questions_container.dart';
import 'package:ebeere/utils/answer_encryption.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/internet_connectivity.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
        body: DecoratedBackground(
          shapesCount: 23,
          shapesSeed: 999,
          child: MultiBlocListener(
            listeners: [
            //update ui and do other callback based on changes in MultiUserBattleRoomCubit
            BlocListener<MultiUserBattleRoomCubit, MultiUserBattleRoomState>(
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
                    showAlreadyLoggedInDialog(context);
                  }
                }
              },
            ),
          ],
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: opponentUsers.length >= 2 ? 70 : 0,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: showWaitForOthers
                        ? const WaitForOthersContainer(
                            key: Key('waitForOthers'),
                          )
                        : BlocBuilder<
                            MultiUserBattleRoomCubit,
                            MultiUserBattleRoomState
                          >(
                            bloc: battleRoomCubit,
                            builder: (context, state) {
                              return QuestionsContainer(
                                topPadding:
                                    context.height *
                                    RectangleUserProfileContainer
                                        .userDetailsHeightPercentage *
                                    3.5,
                                timerAnimationController:
                                    timerAnimationController,
                                quizType: QuizTypes.groupPlay,
                                answerMode: context
                                    .read<SystemConfigCubit>()
                                    .answerMode,
                                lifeLines: const {},
                                guessTheWordQuestionContainerKeys: const [],
                                key: const Key('questions'),
                                guessTheWordQuestions: const [],
                                hasSubmittedAnswerForCurrentQuestion:
                                    hasSubmittedAnswerForCurrentQuestion,
                                questions: battleRoomCubit.getQuestions(),
                                submitAnswer: submitAnswer,
                                questionContentAnimation:
                                    questionContentAnimation,
                                questionScaleDownAnimation:
                                    questionScaleDownAnimation,
                                questionScaleUpAnimation:
                                    questionScaleUpAnimation,
                                questionSlideAnimation: questionSlideAnimation,
                                currentQuestionIndex: currentQuestionIndex,
                                questionAnimationController:
                                    questionAnimationController,
                                questionContentAnimationController:
                                    questionContentAnimationController,
                              );
                            },
                          ),
                  ),
                ),
              ),
              _buildMessageBoxContainer(),
              ...showUserLeftTheGame
                  ? []
                  : [
                      _buildCurrentUserDetails(
                        battleRoomCubit.getUser(
                          context.read<UserDetailsCubit>().userId(),
                        )!,
                        battleRoomCubit.getQuestions().length.toString(),
                      ),
                      _buildCurrentUserMessageContainer(),

                      //Optimize for more user code
                      //use for loop not add manual user like this
                      BlocBuilder<
                        MultiUserBattleRoomCubit,
                        MultiUserBattleRoomState
                      >(
                        bloc: battleRoomCubit,
                        builder: (context, state) {
                          if (state is MultiUserBattleRoomSuccess) {
                            final opponentUsers = battleRoomCubit
                                .getOpponentUsers(
                                  context.read<UserDetailsCubit>().userId(),
                                );
                            return opponentUsers.isNotEmpty
                                ? _buildOpponentUserDetails(
                                    questionsLength: state.questions.length,
                                    alignment: AlignmentDirectional.bottomEnd,
                                    opponentUsers: opponentUsers,
                                    opponentUserIndex: 0,
                                  )
                                : const SizedBox.shrink();
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      _buildOpponentUserMessageContainer(0),
                      BlocBuilder<
                        MultiUserBattleRoomCubit,
                        MultiUserBattleRoomState
                      >(
                        bloc: battleRoomCubit,
                        builder: (context, state) {
                          if (state is MultiUserBattleRoomSuccess) {
                            final opponentUsers = battleRoomCubit
                                .getOpponentUsers(
                                  context.read<UserDetailsCubit>().userId(),
                                );
                            return opponentUsers.length >= 2
                                ? _buildOpponentUserDetails(
                                    questionsLength: state.questions.length,
                                    alignment: AlignmentDirectional.topStart,
                                    opponentUsers: opponentUsers,
                                    opponentUserIndex: 1,
                                  )
                                : const SizedBox();
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<
                        MultiUserBattleRoomCubit,
                        MultiUserBattleRoomState
                      >(
                        bloc: battleRoomCubit,
                        builder: (context, state) {
                          if (state is MultiUserBattleRoomSuccess) {
                            final opponentUsers = battleRoomCubit
                                .getOpponentUsers(
                                  context.read<UserDetailsCubit>().userId(),
                                );
                            return opponentUsers.length >= 2
                                ? _buildOpponentUserMessageContainer(1)
                                : const SizedBox();
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<
                        MultiUserBattleRoomCubit,
                        MultiUserBattleRoomState
                      >(
                        bloc: battleRoomCubit,
                        builder: (context, state) {
                          if (state is MultiUserBattleRoomSuccess) {
                            final opponentUsers = battleRoomCubit
                                .getOpponentUsers(
                                  context.read<UserDetailsCubit>().userId(),
                                );
                            return opponentUsers.length >= 3
                                ? _buildOpponentUserDetails(
                                    questionsLength: state.questions.length,
                                    alignment: AlignmentDirectional.topEnd,
                                    opponentUsers: opponentUsers,
                                    opponentUserIndex: 2,
                                  )
                                : const SizedBox();
                          }
                          return const SizedBox();
                        },
                      ),
                      BlocBuilder<
                        MultiUserBattleRoomCubit,
                        MultiUserBattleRoomState
                      >(
                        bloc: battleRoomCubit,
                        builder: (context, state) {
                          if (state is MultiUserBattleRoomSuccess) {
                            final opponentUsers = battleRoomCubit
                                .getOpponentUsers(
                                  context.read<UserDetailsCubit>().userId(),
                                );
                            return opponentUsers.length >= 3
                                ? _buildOpponentUserMessageContainer(2)
                                : Container();
                          }
                          return Container();
                        },
                      ),
                    ],
              _buildYouWonContainer(battleRoomCubit),
              _buildUserLeftTheGame(),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

class ImageCircularProgressIndicator extends StatelessWidget {
  const ImageCircularProgressIndicator({
    required this.userBattleRoomDetails,
    required this.animationController,
    required this.totalQues,
    super.key,
  });

  final UserBattleRoomDetails userBattleRoomDetails;
  final AnimationController animationController;
  final String totalQues;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              height: 55,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: QImage.circular(
                      imageUrl: userBattleRoomDetails.profileUrl,
                      height: 48,
                      width: 48,
                    ),
                  ),

                  /// Circle
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CustomPaint(
                        painter: _CircleCustomPainter(
                          color: Theme.of(context).colorScheme.surface,
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                  ),

                  /// Arc
                  Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (_, _) {
                        return SizedBox(
                          width: 50,
                          height: 50,
                          child: CustomPaint(
                            painter: _ArcCustomPainter(
                              color: Theme.of(context).primaryColor,
                              strokeWidth: 4,
                              sweepDegree: 360 * animationController.value,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  ///
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 15,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${userBattleRoomDetails.correctAnswers}/$totalQues',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 10,
                          fontWeight: FontWeights.regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 8),
            Text(
              userBattleRoomDetails.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeights.bold,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleCustomPainter extends CustomPainter {
  const _CircleCustomPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final p = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, size.width * 0.5, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ArcCustomPainter extends CustomPainter {
  const _ArcCustomPainter({
    required this.color,
    required this.strokeWidth,
    required this.sweepDegree,
  });

  final Color color;
  final double strokeWidth;
  final double sweepDegree;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final p = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    /// The PI constant.
    const pi = 3.1415926535897932;

    const startAngle = 3 * (pi / 2);
    final sweepAngle = (sweepDegree * pi) / 180.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width * 0.5),
      startAngle,
      sweepAngle,
      false,
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
