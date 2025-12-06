import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/auth/cubits/auth_cubit.dart';
import 'package:ebeere/features/badges/blocs/badges_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/audio_question_bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/guess_the_word_bookmark_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';

Future<void> showLogoutDialog(BuildContext context) {
  return context.showDialog(
    title: context.tr('logoutLbl'),
    message: context.tr('logoutDialogLbl'),
    image: Assets.logoutAccount,
    confirmButtonText: context.tr('yesLogoutLbl'),
    onConfirm: () {
      context.read<BadgesCubit>().reset();

      context.read<BookmarkCubit>().reset();
      context.read<GuessTheWordBookmarkCubit>().reset();
      context.read<AudioQuestionBookmarkCubit>().reset();

      context.read<AuthCubit>().logoutOrDeleteAccount();
      context.read<UserDetailsCubit>().logoutOrDeleteAccount();

      context.pushReplacementNamed(Routes.login);
    },
    cancelButtonText: context.tr('stayLoggedLbl'),
  );
}
