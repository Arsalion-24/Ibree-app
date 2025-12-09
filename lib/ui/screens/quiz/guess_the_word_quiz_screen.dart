import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/features/quiz/cubits/guess_the_word_quiz_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/quiz_repository.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/features/system_config/model/answer_mode.dart';
import 'package:ebeere/ui/screens/quiz/widgets/guess_the_word_question_container.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/ui/widgets/questions_container.dart';
import 'package:ebeere/ui/widgets/text_circular_timer.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
          body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 204,
        child: Stack(
            children: [
              _buildQuestions(guessTheWordQuizCubit),
              _buildSubmitButton(guessTheWordQuizCubit),
            ],
          ),
        ),
      ),
        ),
    );
  }
}
