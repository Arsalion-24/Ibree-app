import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/ads.dart';
import 'package:ebeere/features/coin_history/blocs/coin_history_cubit.dart';
import 'package:ebeere/features/coin_history/models/coin_history.dart';
import 'package:ebeere/features/coin_history/repos/coin_history_repository.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/datetime_utils.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 403,
        child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: showBannerAd ? 60 : 0),
            child: _buildContent(),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BannerAdContainer(),
          ),
        ],
      ),
    );
  }
}

/// Individual coin history transaction item widget
class _CoinHistoryItem extends StatelessWidget {
  const _CoinHistoryItem({required this.transaction});

  final CoinHistory transaction;

  static const double _borderRadius = 12;
  static const double _shadowBlurRadius = 8;
  static const double _shadowAlpha = 0.08;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateTimeUtils.dateFormat.format(
      DateTime.parse(transaction.date),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: _shadowAlpha),
            blurRadius: _shadowBlurRadius,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _TransactionDetails(
              type: context.tr(transaction.type) ?? transaction.type,
              date: formattedDate,
            ),
          ),
          const SizedBox(width: 12),
          _CoinBadge(
            points: transaction.pointsValue,
            isDeduction: transaction.isDeduction,
          ),
        ],
      ),
    );
  }
}

/// Transaction type and date display
class _TransactionDetails extends StatelessWidget {
  const _TransactionDetails({
    required this.type,
    required this.date,
  });

  final String type;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          type,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: context.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 12,
              color: context.primaryTextColor.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 4),
            Text(
              date,
              style: TextStyle(
                color: context.primaryTextColor.withValues(alpha: 0.5),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Coin points badge with gradient and shadow
class _CoinBadge extends StatelessWidget {
  const _CoinBadge({
    required this.points,
    required this.isDeduction,
  });

  final int points;
  final bool isDeduction;

  static const double _borderRadius = 8;
  static const double _shadowBlurRadius = 8;
  static const double _gradientAlpha = 0.9;
  static const double _glowAlpha = 0.2;

  @override
  Widget build(BuildContext context) {
    final badgeColor = isDeduction ? kHurryUpTimerColor : kAddCoinColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            badgeColor.withValues(alpha: _gradientAlpha),
            badgeColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withValues(alpha: _glowAlpha),
            blurRadius: _shadowBlurRadius,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        isDeduction
            ? UiUtils.formatNumber(points)
            : '+${UiUtils.formatNumber(points)}',
        style: TextStyle(
          color: context.surfaceColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
        ),
    );
  }
}
