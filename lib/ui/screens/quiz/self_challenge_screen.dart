import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/widgets/custom_snackbar.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:ebeere/features/quiz/cubits/subcategory_cubit.dart';
import 'package:ebeere/features/quiz/models/category.dart';
import 'package:ebeere/features/quiz/models/quiz_type.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/ui/widgets/already_logged_in_dialog.dart';
import 'package:ebeere/ui/widgets/custom_appbar.dart';
import 'package:ebeere/ui/widgets/custom_rounded_button.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:google_fonts/google_fonts.dart';
        body: DecoratedBackground(
          shapesCount: 18,
          shapesSeed: 555,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: size.height * UiUtils.vtMarginPct,
              horizontal: size.width * UiUtils.hzMarginPct,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Category Dropdown
                BlocConsumer<QuizCategoryCubit, QuizCategoryState>(
                  bloc: context.read<QuizCategoryCubit>(),
                  listener: (context, state) async {
                    if (state is QuizCategorySuccess) {
                      setState(() {
                        selectedCategoryId = state.categories.first.id;
                        selectedCategory = state.categories.first.categoryName;
                      });
                      unawaited(
                        context.read<SubCategoryCubit>().fetchSubCategory(
                          state.categories.first.id!,
                        ),
                      );
                    }
                    if (state is QuizCategoryFailure) {
                      if (state.errorMessage == errorCodeUnauthorizedAccess) {
                        await showAlreadyLoggedInDialog(context);
                        return;
                      }

                      context.showSnack(
                        context.tr(
                          convertErrorCodeToLanguageKey(state.errorMessage),
                        )!,
                        onAction: _getCategories,
                      );
                    }
                  },
                  builder: (context, state) {
                    var categories = <Category>[];
                    if (state is QuizCategorySuccess) {
                      categories = state.categories
                        ..removeWhere((c) => c.isPremium && !c.hasUnlocked);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('selectCategory')!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildDropdownContainer(
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: state is QuizCategorySuccess
                                ? _buildDropdown(
                                    forCategory: true,
                                    values: categories
                                        .map(
                                          (e) => {
                                            'name': e.categoryName,
                                            'id': e.id,
                                          },
                                        )
                                        .toList(),
                                    keyValue: 'selectCategorySuccess',
                                  )
                                : Opacity(
                                    opacity: 0.75,
                                    child: _buildDropdown(
                                      forCategory: true,
                                      values: [
                                        {
                                          'name': _defaultSelectedCategoryValue,
                                          'id': _defaultSelectedCategoryValue,
                                        },
                                      ],
                                      keyValue: 'selectCategory',
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 25),

                //Sub Category Dropdown
                BlocConsumer<SubCategoryCubit, SubCategoryState>(
                  bloc: context.read<SubCategoryCubit>(),
                  listener: (context, state) async {
                    if (state is SubCategoryFetchSuccess) {
                      setState(() {
                        selectedSubcategoryId = state.subcategoryList.first.id;
                        selectedSubcategory =
                            state.subcategoryList.first.subcategoryName;
                      });
                    } else if (state is SubCategoryFetchFailure) {
                      if (state.errorMessage == errorCodeUnauthorizedAccess) {
                        //
                        await showAlreadyLoggedInDialog(context);
                        return;
                      }

                      // if no subcategory is available.
                      if (state.errorMessage == errorCodeDataNotFound) {
                        return;
                      }

                      context.showSnack(
                        context.tr(
                          convertErrorCodeToLanguageKey(state.errorMessage),
                        )!,
                        onAction: () {
                          //load subcategory again
                          unawaited(
                            context.read<SubCategoryCubit>().fetchSubCategory(
                              selectedCategoryId!,
                            ),
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SubCategoryFetchFailure) {
                      //if there is no subcategory then show empty sized box
                      if (state.errorMessage == errorCodeDataNotFound) {
                        return const SizedBox();
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('selectSubCategory')!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildDropdownContainer(
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _buildSubCategoryDropdownContainer(state),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 25),

                /// Select no. of Questions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleContainer(context.tr('selectNoQusLbl')!),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(
                                  maxQuestions,
                                  (index) =>
                                      config.selfChallengeMaxQuestions < 5
                                      ? config.selfChallengeMaxQuestions
                                      : (index + 1) * 5,
                                )
                                .map(
                                  (e) => _buildSelectTimeAndQuestionContainer(
                                    forSelectQuestion: true,
                                    value: e,
                                    borderColor: selectedNumberOfQuestions == e
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                    backgroundColor:
                                        selectedNumberOfQuestions == e
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).colorScheme.surface,
                                    textColor: selectedNumberOfQuestions == e
                                        ? Theme.of(context).colorScheme.surface
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onTertiary,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                /// Select challenge duration in minutes
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleContainer(context.tr('selectTimeLbl')!),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(
                                  maxMinutes,
                                  (index) => config.selfChallengeMaxMinutes < 3
                                      ? config.selfChallengeMaxMinutes
                                      : (index + 1) * 3,
                                )
                                .map(
                                  (e) => _buildSelectTimeAndQuestionContainer(
                                    forSelectQuestion: false,
                                    value: e,
                                    backgroundColor: selectedMinutes == e
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).colorScheme.surface,
                                    textColor: selectedMinutes == e
                                        ? Theme.of(context).colorScheme.surface
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onTertiary,
                                    borderColor: selectedMinutes == e
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                /// Start Challenge
                CustomRoundedButton(
                  elevation: 5,
                  widthPercentage: 1,
                  backgroundColor: Theme.of(context).primaryColor,
                  buttonTitle: context.tr('startLbl')!.toUpperCase(),
                  fontWeight: FontWeight.bold,
                  radius: 8,
                  onTap: startSelfChallenge,
                  showBorder: false,
                  titleColor: Theme.of(context).colorScheme.surface,
                  shadowColor: Theme.of(
                    context,
                  ).primaryColor.withValues(alpha: 0.5),
                  height: 50,
                ),
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}
