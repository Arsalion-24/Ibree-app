import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/interstitial_ad_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/battle_room_cubit.dart';
import 'package:ebeere/features/battle_room/models/battle_room.dart';
import 'package:ebeere/features/exam/models/exam.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/update_user_details_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/profile_management/models/user_profile.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/features/quiz/cubits/comprehension_cubit.dart';
import 'package:ebeere/features/quiz/cubits/contest_cubit.dart';
import 'package:ebeere/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:ebeere/features/quiz/cubits/set_coin_score_cubit.dart';
import 'package:ebeere/features/quiz/cubits/subcategory_cubit.dart';
import 'package:ebeere/features/quiz/cubits/unlocked_level_cubit.dart';
import 'package:ebeere/features/quiz/models/comprehension.dart';
import 'package:ebeere/features/quiz/models/guess_the_word_question.dart';
import 'package:ebeere/features/quiz/models/question.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/quiz/models/user_battle_room_details.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/screens/quiz/guess_the_word_quiz_screen.dart';
import 'package:ebeere/ui/screens/quiz/review_answers_screen.dart';
import 'package:ebeere/ui/screens/quiz/widgets/radial_result_container.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/answer_encryption.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
          body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 202,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: _buildResultContainer(context)),
                const SizedBox(height: 20),
                _buildResultButtons(context),
              ],
            ),
          ),
        ),
      ),
        ),
    );
  }
}
