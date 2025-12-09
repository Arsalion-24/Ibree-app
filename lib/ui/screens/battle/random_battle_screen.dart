import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ebeere/commons/widgets/custom_alert_dialog.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/rewarded_ad_cubit.dart';
import 'package:ebeere/features/battle_room/cubits/battle_room_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/screens/battle/create_or_join_screen.dart';
import 'package:ebeere/ui/screens/battle/widgets/top_curve_clipper.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/watch_reward_ad_dialog.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
        body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 103,
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.width,
            height: context.height,
            child: Stack(
              children: [
                /// Title & Back Btn
                Container(
                  width: context.width,
                  height: context.height * .45,
                  color: Theme.of(context).primaryColor,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// BG
                      SvgPicture.asset(
                        Assets.battleDesignImg,
                        fit: BoxFit.cover,
                        width: context.width,
                        height: context.height,
                      ),

                      /// VS
                      Padding(
                        padding: const EdgeInsets.only(top: 75, left: 3),
                        child: SvgPicture.asset(
                          Assets.vsImg,
                          width: 247.177,
                          height: 126.416,
                        ),
                      ),

                      /// Title & Back Button
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          top: context.height * 0.07,
                          start: 25,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: GestureDetector(
                                onTap: Navigator.of(context).pop,
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 24.5,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Text(
                                context.tr('randomLbl')!,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context).colorScheme.surface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  child: ClipPath(
                    clipper: TopCurveClipper(),
                    child: Container(
                      width: context.width,
                      height: context.height * .63,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * UiUtils.hzMarginPct,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: context.height * .07),

                          /// Select Category
                          if (context
                              .read<SystemConfigCubit>()
                              .isCategoryEnabledForRandomBattle)
                            Text(
                              context.tr(selectCategoryKey)!,
                              style: TextStyle(
                                fontWeight: FontWeights.regular,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ),

                          /// dropDown
                          if (context
                              .read<SystemConfigCubit>()
                              .isCategoryEnabledForRandomBattle)
                            SizedBox(height: context.height * .01),
                          if (context
                              .read<SystemConfigCubit>()
                              .isCategoryEnabledForRandomBattle)
                            selectCategoryDropDown(),

                          /// Entry fees & Current user coins
                          SizedBox(height: context.height * .02),
                          _buildEntryFeesAndCoinsCard(context),

                          /// Let's Play
                          SizedBox(height: context.height * .04),
                          letsPlayButton(context),

                          if (context
                              .read<SystemConfigCubit>()
                              .isOneVsOneBattleEnabled) ...[
                            /// OR
                            SizedBox(height: context.height * .02),
                            _buildOrDivider(context),

                            /// Let's Play
                            SizedBox(height: context.height * .02),
                            playWithFrndsButton(context),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomRoundedButton playWithFrndsButton(BuildContext context) {
    return CustomRoundedButton(
      widthPercentage: context.width,
      backgroundColor: Theme.of(context).primaryColor,
      buttonTitle: context.tr('playWithFrdLbl'),
      radius: 8,
      showBorder: false,
      height: context.height * .07,
      fontWeight: FontWeights.semiBold,
      textSize: 18,
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<CreateOrJoinRoomScreen>(
            builder: (_) => BlocProvider<UpdateCoinsCubit>(
              create: (_) => UpdateCoinsCubit(ProfileManagementRepository()),
              child: CreateOrJoinRoomScreen(
                quizType: QuizTypes.oneVsOneBattle,
                title: context.tr('playWithFrdLbl')!,
              ),
            ),
          ),
        );
      },
    );
  }

  CustomRoundedButton letsPlayButton(BuildContext context) {
    return CustomRoundedButton(
      widthPercentage: context.width,
      backgroundColor: Theme.of(context).primaryColor,
      buttonTitle: context.tr('letsPlay'),
      radius: 8,
      showBorder: false,
      height: context.height * .07,
      fontWeight: FontWeights.semiBold,
      textSize: 18,
      onTap: () {
        final userProfile = context.read<UserDetailsCubit>().getUserProfile();

        if (int.parse(userProfile.coins!) <
            context.read<SystemConfigCubit>().randomBattleEntryCoins) {
          //if ad not loaded than show not enough coins
          if (context.read<RewardedAdCubit>().state is! RewardedAdLoaded) {
            context.showErrorDialog(
              context.tr(
                convertErrorCodeToLanguageKey(errorCodeNotEnoughCoins),
              )!,
            );
            return;
          }

          showWatchAdDialog(
            context,
            onConfirm: () {
              context.read<RewardedAdCubit>().showAd(
                context: context,
                onAdDismissedCallback: _addCoinsAfterRewardAd,
              );
            },
          );
          return;
        }
        if (selectedCategory == selectCategoryKey &&
            context
                .read<SystemConfigCubit>()
                .isCategoryEnabledForRandomBattle) {
          context.showErrorDialog(
            context.tr(pleaseSelectCategoryKey)!,
          );
          return;
        }

        context.read<BattleRoomCubit>().updateState(const BattleRoomInitial());

        Navigator.of(context).pushReplacementNamed(
          Routes.battleRoomFindOpponent,
          arguments: selectedCategoryId,
        );
      },
    );
  }

  Container _buildEntryFeesAndCoinsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      width: context.width,
      height: context.height * .14,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${context.tr("entryFeesLbl")!}\n",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeights.regular,
                    color: Theme.of(
                      context,
                    ).colorScheme.onTertiary.withValues(alpha: .4),
                  ),
                ),
                TextSpan(
                  text:
                      '${context.read<SystemConfigCubit>().randomBattleEntryCoins} ${context.tr(coinsLbl)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeights.bold,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            indent: context.width * .07,
            endIndent: context.width * .07,
            color: Theme.of(
              context,
            ).colorScheme.onTertiary.withValues(alpha: .6),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${context.tr(currentCoinsKey)!}\n',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeights.regular,
                    color: Theme.of(
                      context,
                    ).colorScheme.onTertiary.withValues(alpha: .4),
                  ),
                ),
                WidgetSpan(
                  child: BlocBuilder<UserDetailsCubit, UserDetailsState>(
                    bloc: context.read<UserDetailsCubit>(),
                    builder: (context, state) {
                      return state is UserDetailsFetchSuccess
                          ? Text(
                              '${context.read<UserDetailsCubit>().getCoins()!} ${context.tr(coinsLbl)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeights.bold,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildOrDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(
              context,
            ).colorScheme.onTertiary.withValues(alpha: .6),
            thickness: .5,
            indent: context.width * .1,
            endIndent: context.width * .05,
          ),
        ),
        Text(
          context.tr(orLbl)!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeights.regular,
            color: Theme.of(
              context,
            ).colorScheme.onTertiary.withValues(alpha: .6),
          ),
        ),
        Expanded(
          child: Divider(
            color: Theme.of(
              context,
            ).colorScheme.onTertiary.withValues(alpha: .6),
            thickness: .5,
            indent: context.width * .05,
            endIndent: context.width * .1,
          ),
        ),
      ],
    );
        ),
  }
}
