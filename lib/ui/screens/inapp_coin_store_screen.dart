import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ebeere/commons/widgets/custom_snackbar.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/auth/cubits/auth_cubit.dart';
import 'package:ebeere/features/in_app_purchase/in_app_product.dart';
import 'package:ebeere/features/in_app_purchase/in_app_purchase_cubit.dart';
import 'package:ebeere/features/in_app_purchase/in_app_purchase_repo.dart';
import 'package:ebeere/features/profile_management/cubits/update_score_and_coins_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/update_user_details_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/ui/widgets/all.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
        body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 505,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: BlocConsumer<InAppPurchaseCubit, InAppPurchaseState>(
                bloc: context.read<InAppPurchaseCubit>(),
                listener: (context, state) async {
                  if (state is InAppPurchaseProcessSuccess) {
                    final iap = iapProducts.firstWhere(
                      (e) => e.productId == state.purchasedProductId,
                    );

                    final success = await context
                        .read<InAppPurchaseCubit>()
                        .verifyAndPurchase();

                    if (success) {
                      // We don't want to show the Remove Ads IAP, after purchasing it.
                      if (iap.isRemoveAds) {
                        context.read<UserDetailsCubit>().updateUserProfile(
                          adsRemovedForUser: '1',
                        );

                        state.products.removeWhere(
                          (e) => e.id == iap.productId,
                        );
                        setState(() {});
                      } else {
                        unawaited(
                          context.read<UserDetailsCubit>().fetchUserDetails(),
                        );
                      }

                      ///
                      context.showSnack(
                        "${iap.title} ${context.tr("boughtSuccess")!}",
                      );
                    }
                  } else if (state is InAppPurchaseProcessFailure) {
                    if (!state.errorMessage.contains('userCanceled')) {
                      final error =
                          context.tr(
                            convertErrorCodeToLanguageKey(state.errorMessage),
                          ) ??
                          '';
                      if (error.isNotEmpty) {
                        context.showSnack(error);
                      }
                    }
                  }
                },
                builder: (context, state) {
                  if (fetchError.isNotEmpty) {
                    return Center(
                      child: ErrorContainer(
                        showBackButton: false,
                        errorMessage: convertErrorCodeToLanguageKey(fetchError),
                        onTapRetry: () async {
                          await fetchProducts();
                          initPurchase();
                        },
                        showErrorImage: true,
                      ),
                    );
                  }

                  //initial state of cubit
                  if (state is InAppPurchaseInitial ||
                      state is InAppPurchaseLoading) {
                    return const Center(child: CircularProgressContainer());
                  }

                  //if occurred problem while fetching product details
                  //from appstore or playstore
                  if (state is InAppPurchaseFailure) {
                    return Center(
                      child: ErrorContainer(
                        showBackButton: false,
                        errorMessage: state.errorMessage,
                        onTapRetry: initPurchase,
                        showErrorImage: true,
                      ),
                    );
                  }

                  if (state is InAppPurchaseNotAvailable) {
                    return Center(
                      child: ErrorContainer(
                        showBackButton: false,
                        errorMessage: inAppPurchaseUnavailableKey,
                        onTapRetry: initPurchase,
                        showErrorImage: true,
                      ),
                    );
                  }

                  //if any error occurred in while making in-app purchase
                  if (state is InAppPurchaseProcessFailure) {
                    return _buildProducts(state.products);
                  }
                  if (state is InAppPurchaseAvailable) {
                    return _buildProducts(state.products);
                  }
                  if (state is InAppPurchaseProcessSuccess) {
                    return _buildProducts(state.products);
                  }
                  if (state is InAppPurchaseProcessInProgress) {
                    final textTheme = Theme.of(context).textTheme;
                    final textColor = Theme.of(context).canvasColor;

                    return Stack(
                      children: [
                        _buildProducts(state.products),
                        Container(
                          width: double.maxFinite,
                          color: Colors.black26,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressContainer(),
                              Text(
                                context.tr('iapProcessingTitle')!,
                                style: textTheme.titleLarge?.copyWith(
                                  color: textColor,
                                ),
                              ),
                              Text(
                                context.tr('iapProcessingMessage')!,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
        ),
    );
  }
}
