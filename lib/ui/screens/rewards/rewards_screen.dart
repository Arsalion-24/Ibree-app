import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/badges/blocs/badges_cubit.dart';
import 'package:ebeere/features/badges/models/badge.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/ui/screens/rewards/scratch_reward_screen.dart';
import 'package:ebeere/ui/screens/rewards/widgets/unlocked_reward_content.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_back_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
    return DecoratedBackground(
      shapesCount: 20,
      shapesSeed: 543,
      child: BlocBuilder<BadgesCubit, BadgesState>(
        bloc: context.read<BadgesCubit>(),
        builder: (context, state) {
        if (state is BadgesFetchFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: ErrorContainer(
                errorMessage: convertErrorCodeToLanguageKey(
                  state.errorMessage,
                ),
                onTapRetry: () {
                  context.read<BadgesCubit>().getBadges();
                },
                showErrorImage: true,
              ),
            ),
          );
        }

        if (state is BadgesFetchSuccess) {
          final rewards = context.read<BadgesCubit>().getRewards();

          /// If there are no rewards
          if (rewards.isEmpty) {
            return Center(child: Text(context.tr(noRewardsKey)!));
          }

          //create grid count
          return GridView.builder(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: context.height * UiUtils.vtMarginPct,
              horizontal: context.width * UiUtils.hzMarginPct,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemCount: rewards.length,
            itemBuilder: (_, i) {
              final reward = rewards[i];

              return SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, .2),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _entranceAnimationController,
                        curve: Interval(
                          .1 * i,
                          1,
                          curve: Curves.easeOutCubic,
                        ),
                      ),
                    ),
                child: Hero(
                  tag: reward.type,
                  child: _buildRewardContainer(reward),
                ),
              );
            },
          );
        }

        return const Center(child: CircularProgressContainer());
      },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        shadowColor: context.surfaceColor.withValues(alpha: 0.4),
        backgroundColor: context.primaryColor,
        foregroundColor: context.surfaceColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        leading: QBackButton(
          removeSnackBars: false,
          color: context.surfaceColor,
        ),
        title: Text(
          context.tr(rewardsLbl)!,
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeights.bold,
            color: context.colorScheme.onPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: BlocBuilder<BadgesCubit, BadgesState>(
              bloc: context.read<BadgesCubit>(),
              builder: (context, state) {
                return RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${context.read<BadgesCubit>().getRewardedCoins()} ${context.tr(coinsLbl)!}',
                        style: context.headlineLarge?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      TextSpan(
                        text: '\n${context.tr(totalRewardsEarnedKey)!}',
                        style: context.bodyLarge?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: _buildRewards(),
    );
  }
}
