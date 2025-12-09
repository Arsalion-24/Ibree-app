import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/auth/cubits/auth_cubit.dart';
import 'package:ebeere/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:ebeere/features/quiz/models/category.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
        body: DecoratedBackground(
          shapesCount: 20,
          shapesSeed: 999,
          child: _buildCategoriesListView(),
        ),
      ),
    );
  }

  Widget _buildCategoriesListView() {
    return BlocConsumer<QuizCategoryCubit, QuizCategoryState>(
      builder: (context, state) {
        if (state is QuizCategoryFailure) {
          return ErrorContainer(
            showBackButton: false,
            errorMessageColor: context.primaryColor,
            showErrorImage: true,
            errorMessage: convertErrorCodeToLanguageKey(state.errorMessage),
            onTapRetry: _fetchCategories,
          );
        }

        if (state is QuizCategorySuccess) {
          return RefreshIndicator(
            key: refreshKey,
            color: context.primaryColor,
            backgroundColor: context.scaffoldBackgroundColor,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1), () async {
                await _fetchCategories();
              });
            },
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, i) =>
                  _buildCategoryItem(context, state.categories[i]),
              separatorBuilder: (_, i) =>
                  const SizedBox(height: UiUtils.listTileGap),
              itemCount: state.categories.length,
            ),
          );
        }

        return const Center(child: CircularProgressContainer());
      },
      listener: (context, state) {
        if (state is QuizCategoryFailure) {
          if (state.errorMessage == errorCodeUnauthorizedAccess) {
            showAlreadyLoggedInDialog(context);
          }
        }
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () => _onTapCategory(context, category),
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          final imageUrl = category.image ?? '';

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                left: boxConstraints.maxWidth * 0.1,
                right: boxConstraints.maxWidth * 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 25),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Color(0x40808080),
                      ),
                    ],
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(boxConstraints.maxWidth * .525),
                    ),
                  ),
                  width: boxConstraints.maxWidth,
                  height: 50,
                ),
              ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(12),
                  width: boxConstraints.maxWidth,
                  child: Row(
                    children: [
                      /// Leading Image
                      Align(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: context.primaryTextColor.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: QImage(imageUrl: imageUrl, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      /// title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.categoryName!,
                              maxLines: 1,
                              style: TextStyle(
                                color: context.primaryTextColor,
                                fontSize: 18,
                                fontWeight: FontWeights.semiBold,
                              ),
                            ),
                            Text(
                              category.hasSubcategories
                                  ? "${context.tr("subCategoriesLbl")!}: ${category.subcategoriesCount}"
                                  : "${context.tr("questions")!}: ${category.questionsCount}",
                              style: TextStyle(
                                fontSize: 14,
                                color: context.primaryTextColor.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      /// right arrow
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PremiumCategoryAccessBadge(
                            hasUnlocked: category.hasUnlocked,
                            isPremium: category.isPremium,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: context.primaryTextColor.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: context.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
