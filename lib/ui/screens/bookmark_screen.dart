import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:ebeere/commons/widgets/custom_snackbar.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/bookmark/bookmark_repository.dart';
import 'package:ebeere/features/bookmark/cubits/audio_question_bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/guess_the_word_bookmark_cubit.dart';
import 'package:ebeere/features/bookmark/cubits/update_bookmark_cubit.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/widgets/circular_progress_container.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/ui/widgets/error_container.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
      body: DecoratedBackground(
        shapesCount: 19,
        shapesSeed: 890,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.height * UiUtils.vtMarginPct,
            horizontal: context.width * UiUtils.hzMarginPct,
          ),
          child: TabBarView(
            controller: tabController,
            children: tabs.map((tab) => tab.$2).toList(),
          ),
        ),
      ),
    );
  }
}

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({
    required this.index,
    required this.title,
    required this.queId,
    required this.type,
    required this.onTap,
    super.key,
    this.isLatex = false,
  });

  final String index;
  final String title;
  final String queId;
  final String type;
  final bool isLatex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.height * .1,
        width: context.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xffFFD7E5),
                  ),
                  width: constraints.maxWidth * .13,
                  height: constraints.maxWidth * .13,
                  child: Center(
                    child: Text(
                      index,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeights.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                SizedBox(
                  width: constraints.maxWidth * .722,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///
                      if (isLatex) ...[
                        Expanded(
                          child: TeXView(
                            child: TeXViewGroup(
                              children: [
                                TeXViewGroupItem(
                                  id: '-',
                                  child: TeXViewDocument(
                                    title,
                                    style: TeXViewStyle(
                                      contentColor: Theme.of(
                                        context,
                                      ).colorScheme.onTertiary,
                                      fontStyle: TeXViewFontStyle(
                                        sizeUnit: TeXViewSizeUnit.pixels,
                                        fontSize: 16,
                                        fontWeight: TeXViewFontWeight.w500,
                                      ),
                                      margin: const TeXViewMargin.only(
                                        bottom: 10,
                                        sizeUnit: TeXViewSizeUnit.pixels,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              onTap: (_) => onTap(),
                            ),
                            renderingEngine:
                                const TeXViewRenderingEngine.katex(),
                          ),
                        ),
                      ] else ...[
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeights.bold,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                /// Close
                GestureDetector(
                  onTap: () {
                    context.read<UpdateBookmarkCubit>().updateBookmark(
                      queId,
                      '0',
                      type,
                    );
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
