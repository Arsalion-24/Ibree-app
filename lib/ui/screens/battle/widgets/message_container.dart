import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/core/constants/assets_constants.dart';
import 'package:ebeere/features/battle_room/cubits/battle_room_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/message_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/multi_user_battle_room_cubit.dart';
import 'package:ebeere/features/battle_room/models/message.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:google_fonts/google_fonts.dart';

/// Chat message bubble - redesigned as simple purple/gray pills
/// Matches client UI specifications
class MessageContainer extends StatelessWidget {
  const MessageContainer({
    required this.isCurrentUser,
    required this.quizType,
    super.key,
    this.opponentUserIndex,
  });

  final bool isCurrentUser;
  final QuizTypes quizType;
  final int? opponentUserIndex;

  Widget _buildMessage(BuildContext context, MessageState messageState) {
    if (messageState is MessageFetchedSuccess) {
      if (messageState.messages.isEmpty) {
        return const SizedBox();
      }
      var message = Message.empty;

      final currentUserId = context.read<UserDetailsCubit>().userId();

      if (quizType == QuizTypes.oneVsOneBattle) {
        final battleRoomCubit = context.read<BattleRoomCubit>();
        if (isCurrentUser) {
          message = context.read<MessageCubit>().getUserLatestMessage(
            battleRoomCubit.getCurrentUserDetails(currentUserId).uid,
          );
        } else {
          message = context.read<MessageCubit>().getUserLatestMessage(
            battleRoomCubit.getOpponentUserDetails(currentUserId).uid,
          );
        }
      } else {
        final battleRoomCubit = context.read<MultiUserBattleRoomCubit>();
        if (isCurrentUser) {
          message = context.read<MessageCubit>().getUserLatestMessage(
            battleRoomCubit.getUser(currentUserId)!.uid,
          );
        } else {
          final opponentUserId = battleRoomCubit
              .getOpponentUsers(currentUserId)[opponentUserIndex!]!
              .uid;
          message = context.read<MessageCubit>().getUserLatestMessage(
            battleRoomCubit.getUser(opponentUserId)!.uid,
          );
        }
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: message.isTextMessage
            ? Text(
                message.message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              )
            : SvgPicture.asset(
                Assets.emoji(message.message),
                height: 24,
              ),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    // Purple pill for opponent, gray pill for current user
    final backgroundColor = isCurrentUser
        ? Colors.grey[400]!
        : klPrimaryColor;

    return Container(
      constraints: BoxConstraints(
        minWidth: context.width * 0.2,
        maxWidth: context.width * 0.45,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BlocBuilder<MessageCubit, MessageState>(
        bloc: context.read<MessageCubit>(),
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _buildMessage(context, state),
          );
        },
      ),
    );
  }
}
