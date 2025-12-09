import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/auth/cubits/auth_cubit.dart';
import 'package:ebeere/features/auth/models/auth_providers_enum.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/settings/settings_cubit.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
      body: DecoratedBackground(
        shapesCount: 20,
        shapesSeed: 222,
        child: Column(
          children: [
            _buildProfileHeader(),
            Expanded(child: _buildMenuSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          (previous is Authenticated) != (current is Authenticated),
      builder: (context, authState) {
        final isAuthenticated = authState is Authenticated;

        return FutureBuilder<bool>(
          future: _gdprFuture,
          builder: (context, gdprSnapshot) {
            final isUnderGdpr =
                gdprSnapshot.hasData && (gdprSnapshot.data ?? false);

            final visibleItems = _getVisibleMenuItems(
              isAuthenticated: isAuthenticated,
              isUnderGdpr: isUnderGdpr,
            );

            return _buildMenuList(visibleItems);
          },
        );
      },
    );
  }

  Widget _buildMenuList(List<MenuItem> visibleItems) {
    final gridItems = visibleItems.take(3).toList();
    final listItems = visibleItems.skip(3).toList();

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: context.width * UiUtils.hzMarginPct,
        vertical: context.height * UiUtils.vtMarginPct,
      ),
      children: [
        _buildGrid(gridItems),
        const SizedBox(height: 16),
        _buildList(listItems),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGrid(List<MenuItem> items) {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 20,
      physics: const NeverScrollableScrollPhysics(),
      children: items.map(_buildGridViewItem).toList(),
    );
  }

  Widget _buildList(List<MenuItem> items) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: UiUtils.listTileGap),
      itemBuilder: (_, i) => _buildListViewItem(items[i]),
    );
  }

  Widget _buildProfileHeader() {
    void onTapEditProfile() {
      if (_isGuest) {
        showLoginRequiredDialog(context);
        return;
      }

      globalCtx.pushNamed(
        Routes.selectProfile,
        arguments: const CreateOrEditProfileScreenArgs(isNewUser: false),
      );
    }

    return SizedBox(
      height: context.height * .25,
      width: double.maxFinite,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final maxWidth = constraints.maxWidth;

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                height: maxHeight * .8,
                width: maxWidth,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Text(
                  context.tr('profileLbl')!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: maxHeight * .35,
                      width: maxWidth * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(
                            color: context.primaryTextColor.withValues(
                              alpha: .1,
                            ),
                            blurRadius: 8,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: maxHeight * .45,
                      margin: EdgeInsets.symmetric(
                        horizontal: context.width * UiUtils.hzMarginPct,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.surfaceColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final maxHeight = constraints.maxHeight;

                          return BlocBuilder<
                            UserDetailsCubit,
                            UserDetailsState
                          >(
                            builder: (context, state) {
                              if (state is UserDetailsFetchInProgress) {
                                return const Center(
                                  child: CircularProgressContainer(),
                                );
                              }

                              var profileUrl = '';
                              var username = context.tr('helloGuest')!;
                              var profileDesc = context.tr(
                                'provideGuestDetails',
                              )!;

                              if (state is UserDetailsFetchSuccess) {
                                profileUrl = state.userProfile.profileUrl!;
                                username = state.userProfile.name!;

                                if (context
                                        .read<AuthCubit>()
                                        .getAuthProvider() ==
                                    AuthProviders.mobile) {
                                  profileDesc =
                                      state.userProfile.mobileNumber ?? '';
                                } else {
                                  profileDesc = state.userProfile.email ?? '';
                                }
                              }

                              return Row(
                                children: [
                                  Container(
                                    height: maxHeight,
                                    width: maxHeight,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: context.primaryTextColor
                                            .withValues(alpha: .1),
                                      ),
                                    ),
                                    child: QImage.circular(
                                      imageUrl: profileUrl,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          username,
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: context.primaryTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          profileDesc,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: context.primaryTextColor
                                                .withValues(alpha: .3),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  InkWell(
                                    onTap: onTapEditProfile,
                                    child: Container(
                                      height: maxHeight * .5,
                                      width: maxHeight * .5,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: context.primaryTextColor
                                              .withValues(alpha: .1),
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: QImage(
                                        imageUrl: Assets.editIcon,
                                        color: context.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGridViewItem(MenuItem item) {
    return InkWell(
      onTap: () => _onTapMenuItem(item.name),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image
            Container(
              height: 44,
              width: 44,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: context.scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: QImage(
                imageUrl: item.image,
                color: context.primaryColor,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 85,
              child: Text(
                context.tr(item.name)!,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeights.regular,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  color: context.primaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListViewItem(MenuItem item) {
    Widget? trailing;

    if (item.name == 'soundLbl') {
      trailing = const _SoundSwitchWidget();
    } else if (item.name == 'vibrationLbl') {
      trailing = const _VibrationSwitchWidget();
    }

    return InkWell(
      onTap: () => _onTapMenuItem(item.name),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            QImage(
              imageUrl: item.image,
              color: context.primaryColor,
              fit: BoxFit.fitHeight,
              height: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.tr(item.name)!,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeights.regular,
                  fontSize: 16,
                  color: context.primaryTextColor,
                ),
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing],
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// Extracts only sound value from settings state to prevent rebuilds
/// when other settings (vibration, notifications, etc.) change
class _SoundSwitchWidget extends StatelessWidget {
  const _SoundSwitchWidget();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state.settingsModel!.sound,
      builder: (context, isSoundEnabled) {
        return CustomSwitch(
          value: isSoundEnabled,
          onChanged: (v) => context.read<SettingsCubit>().sound = v,
        );
      },
    );
  }
}

/// Extracts only vibration value from settings state to prevent rebuilds
/// when other settings (sound, notifications, etc.) change
class _VibrationSwitchWidget extends StatelessWidget {
  const _VibrationSwitchWidget();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state.settingsModel!.vibration,
      builder: (context, isVibrationEnabled) {
        return CustomSwitch(
          value: isVibrationEnabled,
          onChanged: (v) => context.read<SettingsCubit>().vibration = v,
        );
      },
    );
  }
}
