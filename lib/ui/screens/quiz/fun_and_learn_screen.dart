import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/quiz/models/comprehension.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/ui/widgets/all.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
          body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 208,
        child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: _buildParagraph(player),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildStartButton(),
              ),
            ],
          ),
        ),
        );
      },
    );
  }
}
