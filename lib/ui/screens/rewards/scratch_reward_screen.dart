import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/badges/blocs/badges_cubit.dart';
import 'package:ebeere/features/badges/models/badge.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/ui/screens/rewards/widgets/unlocked_reward_content.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:scratcher/widgets.dart';
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 401,
        child: Stack(
        children: [
          Align(
            child: Hero(
              tag: widget.reward.type,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  height: context.height * 0.4,
                  width: context.width * 0.8,
                  child: Scratcher(
                    onChange: _onChange,
                    onThreshold: _onThreshold,
                    key: scratcherKey,
                    brushSize: 35,
                    threshold: 50,
                    accuracy: ScratchAccuracy.medium,
                    color: Theme.of(context).primaryColor,
                    image: Image.asset(Assets.scratchCardCover),
                    child: UnlockedRewardContent(
                      reward: widget.reward,
                      increaseFont: true,
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///
          if (_showScratchHere)
            Align(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.3),
                  ),
                  height: context.height * 0.075,
                  width: context.width * 0.8,
                  child: Center(
                    child: Text(
                      context.tr(scratchHereKey)!,
                      style: TextStyle(
                        color: colorScheme.surface,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
        ),
    );
  }
}
