import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/rewarded_ad_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/battle_room_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/multi_user_battle_room_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/features/system_config/model/room_code_char_type.dart';
import 'package:ebeere/ui/screens/battle/widgets/battle_invite_card.dart';
import 'package:ebeere/ui/screens/battle/widgets/top_curve_clipper.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
                        child: DecoratedBackground(
                          shapesCount: 18,
                          shapesSeed: 567,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                            /// Create Room Btn
                            CustomRoundedButton(
                              widthPercentage: context.width,
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: 10,
                              showBorder: false,
                              height: 50,
                              onTap: showCreateRoomBottomSheet,
                              buttonTitle: context.tr('createRoom'),
                            ),
                            SizedBox(height: size.height * 0.025),

                            /// Join Room Btn
                            CustomRoundedButton(
                              widthPercentage: context.width,
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: 10,
                              showBorder: false,
                              height: 50,
                              onTap: showJoinRoomBottomSheet,
                              buttonTitle: context.tr('joinRoom'),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
