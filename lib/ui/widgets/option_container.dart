import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/core/config/colors.dart';
import 'package:ebeere/core/constants/constants.dart';
import 'package:ebeere/features/quiz/models/answer_option.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/settings/settings_cubit.dart';
import 'package:ebeere/features/system_config/model/answer_mode.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class OptionContainer extends StatefulWidget {
  const OptionContainer({
    required this.quizType,
    required this.answerMode,
    required this.showAudiencePoll,
    required this.hasSubmittedAnswerForCurrentQuestion,
    required this.constraints,
    required this.answerOption,
    required this.correctOptionId,
    required this.submitAnswer,
    required this.submittedAnswerId,
    this.canResubmitAnswer = false,
    this.audiencePollPercentage,
    this.trueFalseOption = false,
    super.key,
  });

  final bool Function() hasSubmittedAnswerForCurrentQuestion;
  final void Function(String) submitAnswer;
  final AnswerOption answerOption;
  final BoxConstraints constraints;
  final String correctOptionId;
  final String submittedAnswerId;
  final bool showAudiencePoll;
  final int? audiencePollPercentage;
  final AnswerMode answerMode;
  final bool canResubmitAnswer;
  final QuizTypes quizType;
  final bool trueFalseOption;

  @override
  State<OptionContainer> createState() => _OptionContainerState();
}

class _OptionContainerState extends State<OptionContainer>
    with TickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 90),
  );
  late Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(parent: animationController, curve: Curves.easeInQuad),
  );

  late AnimationController topContainerAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 180),
      );
  late Animation<double> topContainerOpacityAnimation =
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: topContainerAnimationController,
          curve: const Interval(0, 0.25, curve: Curves.easeInQuad),
        ),
      );

  late Animation<double> topContainerAnimation = Tween<double>(begin: 0, end: 1)
      .animate(
        CurvedAnimation(
          parent: topContainerAnimationController,
          curve: const Interval(0, 0.5, curve: Curves.easeInQuad),
        ),
      );

  late Animation<double> answerCorrectnessAnimation =
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: topContainerAnimationController,
          curve: const Interval(0.5, 1, curve: Curves.easeInQuad),
        ),
      );

  late double heightPercentage = 0.105;
  late final _audioPlayer = AudioPlayer();

  late TextSpan textSpan = TextSpan(
    text: widget.answerOption.title,
    style: GoogleFonts.nunito(
      textStyle: TextStyle(
        color: optionTextColor,
        height: 1,
        fontSize: 20,
      ),
    ),
  );

  @override
  void dispose() {
    animationController.dispose();
    topContainerAnimationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSound(String trackName) async {
    if (context.read<SettingsCubit>().getSettings().sound) {
      if (_audioPlayer.playing) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.setAsset(trackName);
      await _audioPlayer.play();
    }
  }

  Future<void> playVibrate() async {
    if (context.read<SettingsCubit>().getSettings().vibration) {
      UiUtils.vibrate();
    }
  }

  int calculateMaxLines() {
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: Directionality.of(context),
    )..layout(maxWidth: widget.constraints.maxWidth * 0.85);

    return textPainter.computeLineMetrics().length;
  }

  bool get isCorrectAnswer => widget.answerOption.id == widget.correctOptionId;

  bool get isSubmittedAnswer =>
      widget.answerOption.id == widget.submittedAnswerId;

  Color get optionTextColor {
    final colorScheme = Theme.of(context).colorScheme;
    // Text always stays dark (readable on white background)
    return colorScheme.onTertiary;
  }

  Color _buildOptionBackgroundColor() {
    // Background always stays white/surface color
    return Theme.of(context).colorScheme.surface;
  }

  /// Get left border color based on answer state
  Color _getBorderColor() {
    if (widget.answerMode == AnswerMode.noAnswerCorrectness) {
      return isSubmittedAnswer
          ? Theme.of(context).primaryColor
          : kAnswerBorderGray;
    }

    if (widget.hasSubmittedAnswerForCurrentQuestion()) {
      if (widget.answerMode ==
          AnswerMode.showAnswerCorrectnessAndCorrectAnswer) {
        return isCorrectAnswer
            ? kCorrectAnswerColor
            : isSubmittedAnswer
            ? kWrongAnswerColor
            : kAnswerBorderGray;
      } else {
        return isSubmittedAnswer
            ? isCorrectAnswer
                  ? kCorrectAnswerColor
                  : kWrongAnswerColor
            : kAnswerBorderGray;
      }
    }

    return kAnswerBorderGray;
  }

  void _onTapOptionContainer() {
    if (widget.answerMode == AnswerMode.noAnswerCorrectness) {
      widget.submitAnswer(widget.answerOption.id!);

      playSound(Assets.sfxClickEvent);
      playVibrate();
    } else {
      if (!widget.hasSubmittedAnswerForCurrentQuestion()) {
        widget.submitAnswer(widget.answerOption.id!);

        topContainerAnimationController.forward();

        if (widget.correctOptionId == widget.answerOption.id) {
          playSound(Assets.sfxCorrectAnswer);
        } else {
          playSound(Assets.sfxWrongAnswer);
        }
        playVibrate();
      }
    }
  }

  Widget _buildOptionDetails(double optionWidth) {
    final maxLines = calculateMaxLines();
    if (!widget.hasSubmittedAnswerForCurrentQuestion()) {
      heightPercentage = maxLines > 2
          ? (heightPercentage + (0.03 * (maxLines - 2)))
          : heightPercentage;
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (_, child) {
        return Transform.scale(
          scale: animation.drive(Tween<double>(begin: 1, end: 0.9)).value,
          child: child,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: widget.constraints.maxHeight * 0.015),
        height: widget.quizType == QuizTypes.groupPlay
            ? widget.constraints.maxHeight * (heightPercentage * 0.75)
            : widget.constraints.maxHeight * heightPercentage,
        width: optionWidth,
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: _buildOptionBackgroundColor(),
            borderRadius: BorderRadius.circular(12),
            // LEFT-SIDE COLORED BORDER - KEY DESIGN ELEMENT
            border: Border(
              left: BorderSide(
                color: _getBorderColor(),
                width: 4,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: maxLines > 2 ? 10 : 12,
          ),
          alignment: Alignment.center,
          child: RichText(text: textSpan, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    textSpan = TextSpan(
      text: widget.answerOption.title,
      style: GoogleFonts.nunito(
        textStyle: TextStyle(
          color: optionTextColor,
          height: 1,
          fontSize: 20,
        ),
      ),
    );
    return GestureDetector(
      onTapCancel: animationController.reverse,
      onTap: () async {
        await animationController.reverse();
        _onTapOptionContainer();
      },
      onTapDown: (_) => animationController.forward(),
      child: widget.showAudiencePoll
          ? Row(
              children: [
                _buildOptionDetails(widget.constraints.maxWidth * .8),
                const SizedBox(width: 10),
                Text(
                  '${widget.audiencePollPercentage}%',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontWeight: FontWeights.bold,
                    ),
                  ),
                ),
              ],
            )
          : _buildOptionDetails(widget.constraints.maxWidth),
    );
  }
}
