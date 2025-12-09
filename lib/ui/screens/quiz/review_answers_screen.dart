import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:ebeere/commons/widgets/custom_snackbar.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/bookmark/bookmark_repository.dart';
import 'package:ebeere/features/bookmark/cubits/audio_question_bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/guess_the_word_bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/update_bookmark_cubit.dart';
import 'package:ebeere/features/music_player/music_player_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/models/answer_option.dart';
import 'package:ebeere/features/quiz/models/guess_the_word_question.dart';
import 'package:ebeere/features/quiz/models/question.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/utils/quiz_utils.dart';
import 'package:ebeere/features/report_question/report_question_cubit.dart';
import 'package:ebeere/features/report_question/report_question_repository.dart';
import 'package:ebeere/features/settings/settings_cubit.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/screens/quiz/widgets/music_player_container.dart';
import 'package:ebeere/ui/screens/quiz/widgets/question_container.dart';
import 'package:ebeere/ui/screens/quiz/widgets/report_question_bottom_sheet.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/utils/answer_encryption.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 203,
        child: Stack(
        children: [
          Align(alignment: Alignment.topCenter, child: _buildQuestions()),
          Align(alignment: Alignment.bottomCenter, child: _buildBottomMenu()),
        ],
      ),
    );
  }
}

class LaTeXQuestionContainer extends StatelessWidget {
  const LaTeXQuestionContainer({
    required this.correctAnswerId,
    required this.question,
    super.key,
  });

  final String correctAnswerId;
  final Question question;

  @override
  Widget build(BuildContext context) {
    final submittedAnswerId = question.submittedAnswerId;

    Color optionBackgroundColor(String? optionId) {
      if (optionId == correctAnswerId) return kCorrectAnswerColor;

      if (optionId == submittedAnswerId) return kWrongAnswerColor;

      return context.surfaceColor;
    }

    Color optionTextColor(String? optionId) {
      return optionId == correctAnswerId || optionId == submittedAnswerId
          ? context.surfaceColor
          : context.primaryTextColor;
    }

    final options = question.answerOptions!
        .map(
          (option) => TeXViewDocument(
            option.title!,
            style: TeXViewStyle(
              contentColor: optionTextColor(option.id),
              backgroundColor: optionBackgroundColor(option.id),
              sizeUnit: TeXViewSizeUnit.pixels,
              textAlign: TeXViewTextAlign.center,
              fontStyle: TeXViewFontStyle(
                fontSize: 18,
                sizeUnit: TeXViewSizeUnit.pt,
              ),
              margin: const TeXViewMargin.only(top: 15),
              padding: const TeXViewPadding.only(
                left: 20,
                right: 20,
                bottom: 16,
                top: 16,
              ),
              borderRadius: const TeXViewBorderRadius.all(10),
            ),
          ),
        )
        .toList(growable: false);

    final hasImage = question.imageUrl != null && question.imageUrl!.isNotEmpty;
    final hasNote = question.note != null && question.note!.isNotEmpty;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: context.height * UiUtils.vtMarginPct,
        horizontal: context.width * UiUtils.hzMarginPct,
      ),
      child: TeXView(
        renderingEngine: const TeXViewRenderingEngine.katex(),
        child: TeXViewColumn(
          children: [
            /// Question
            TeXViewDocument(
              question.question!,
              style: TeXViewStyle(
                contentColor: context.primaryTextColor,
                backgroundColor: Colors.transparent,
                sizeUnit: TeXViewSizeUnit.pixels,
                textAlign: TeXViewTextAlign.center,
                fontStyle: TeXViewFontStyle(fontSize: 22),
              ),
            ),

            if (hasImage)
              TeXViewContainer(
                child: TeXViewImage.network(question.imageUrl!),
                style: const TeXViewStyle(
                  textAlign: TeXViewTextAlign.center,
                  sizeUnit: TeXViewSizeUnit.pixels,
                  borderRadius: TeXViewBorderRadius.all(20),
                  padding: TeXViewPadding.all(0),
                  margin: TeXViewMargin.only(top: 20, bottom: 20),
                  height: 200,
                ),
              ),

            ...options,

            /// Notes
            if (hasNote) ...[
              TeXViewDocument(
                context.tr(notesKey)!,
                style: TeXViewStyle(
                  textAlign: TeXViewTextAlign.left,
                  sizeUnit: TeXViewSizeUnit.pt,
                  contentColor: context.primaryColor,
                  fontStyle: TeXViewFontStyle(
                    fontSize: 16,
                    sizeUnit: TeXViewSizeUnit.pt,
                    fontFamily: kFonts.fontFamily,
                    fontWeight: TeXViewFontWeight.bold,
                  ),
                  padding: const TeXViewPadding.all(0),
                  margin: const TeXViewMargin.only(top: 20, bottom: 12),
                ),
              ),
              TeXViewDocument(
                question.note!,
                style: TeXViewStyle(
                  textAlign: TeXViewTextAlign.center,
                  sizeUnit: TeXViewSizeUnit.pt,
                  contentColor: context.primaryTextColor,
                  fontStyle: TeXViewFontStyle(
                    fontSize: 14,
                    sizeUnit: TeXViewSizeUnit.pt,
                    fontFamily: kFonts.fontFamily,
                    fontWeight: TeXViewFontWeight.normal,
                  ),
                  padding: const TeXViewPadding.all(0),
                  margin: const TeXViewMargin.only(bottom: 20),
                ),
              ),
            ] else ...[
              const TeXViewDocument(
                '',
                style: TeXViewStyle(
                  margin: TeXViewMargin.only(
                    bottom: 20,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
        ),
    );
  }
}
