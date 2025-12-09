import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/battle_room/cubits/battle_room_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/screens/battle/widgets/finding_opponent_animation.dart';
import 'package:ebeere/ui/screens/battle/widgets/user_found_map_container.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/custom_back_button.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
          child: DecoratedBackground(
            shapesCount: 20,
            shapesSeed: 789,
            child: Stack(
              children: [
                _buildFindingOpponentMapDetails(),
                _buildPlayersDetails(),
                _buildFindingOpponentStatus(),
                _buildBackButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
