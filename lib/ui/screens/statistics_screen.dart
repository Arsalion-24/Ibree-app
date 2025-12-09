import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ebeere/commons/bottom_nav/models/nav_tab_type_enum.dart';
import 'package:ebeere/commons/screens/dashboard_screen.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/interstitial_ad_cubit.dart';
import 'package:ebeere/features/badges/blocs/badges_cubit.dart';
import 'package:ebeere/features/statistic/cubits/statistics_cubit.dart';
import 'package:ebeere/features/statistic/statistic_repository.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/widgets/all.dart';
import 'package:ebeere/ui/widgets/badges_icon_container.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
      body: DecoratedBackground(
        shapesCount: 17,
        shapesSeed: 678,
        child: BlocConsumer<StatisticCubit, StatisticState>(
          listener: (context, state) {
          if (state is StatisticFetchFailure) {
            if (state.errorMessageCode == errorCodeUnauthorizedAccess) {
              showAlreadyLoggedInDialog(context);
            }
          }
        },
        builder: (_, state) {
          if (state is StatisticInitial || state is StatisticFetchInProgress) {
            return const Center(child: CircularProgressContainer());
          }
          return _buildStatisticsContainer(
            showQuestionAndBattleStatistics: state is StatisticFetchSuccess,
          );
        },
        ),
      ),
    );
  }
}

class StatisticsPieChart extends StatelessWidget {
  const StatisticsPieChart({
    required this.width,
    required this.height,
    required this.values,
    required this.child,
    super.key,
    this.strokeWidth = 8.0,
  });

  final List<({int no, Color arcColor})> values;
  final double width;
  final double height;
  final double strokeWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _StatisticsPieChart(values: values, strokeWidth: strokeWidth),
        child: child,
      ),
    );
  }
}

class _StatisticsPieChart extends CustomPainter {
  _StatisticsPieChart({required this.values, required this.strokeWidth})
    : assert(
        values.isNotEmpty,
        "Values can't be empty. Provide correct values like, for ex. [(no: 10, arcColor: Colors.red)]",
      );

  final List<({int no, Color arcColor})> values;
  final double strokeWidth;

  static const _pi = 3.1415926535897932;

  @override
  void paint(Canvas canvas, Size size) {
    final halfWidth = size.width * .5;
    final center = Offset(size.width * .5, halfWidth);
    final rect = Rect.fromCircle(center: center, radius: halfWidth);

    final total = values.fold(0, (prev, v) => prev += v.no);

    final p = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    /// No Data to Display Chart
    if (total == 0) {
      canvas.drawCircle(center, halfWidth, p..color = Colors.grey.shade300);
      return;
    }

    const pi2 = _pi * 2;
    var oldStart = 3 * (_pi * .5); // 0 deg

    for (final val in values) {
      final sweep = (val.no * pi2) / total;

      canvas.drawArc(rect, oldStart, sweep, false, p..color = val.arcColor);

      oldStart += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
