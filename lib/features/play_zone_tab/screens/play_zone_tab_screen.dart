import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/auth/cubits/auth_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 888,
        child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            _playZones.length,
            (index) {
              final zone = _playZones[index];
              return FadeTransition(
                opacity: _opacityAnimations[index],
                child: ScaleTransition(
                  scale: _scaleAnimations[index],
                  child: QuizGridCard(
                    onTap: () => _onTapQuiz(zone.type),
                    title: context.tr(zone.title)!,
                    desc: context.tr(zone.desc)!,
                    img: zone.img,
                  ),
                ),
              );
            },
          ),
        ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
