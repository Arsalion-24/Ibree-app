import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/auth/auth_local_data_source.dart';
import 'package:ebeere/features/auth/auth_repository.dart';
import 'package:ebeere/features/auth/cubits/auth_cubit.dart';
import 'package:ebeere/features/auth/cubits/refer_and_earn_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/update_user_details_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/upload_profile_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/profile_management/models/user_profile.dart';
import 'package:ebeere/features/profile_management/profile_management_repository.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
        body: DecoratedBackground(
          shapesCount: 18,
          shapesSeed: 789,
          child: Stack(
          children: [
            BlocConsumer<UserDetailsCubit, UserDetailsState>(
              listener: (context, state) {
                //when user register first time then set this listener
                if (state is UserDetailsFetchSuccess && widget.args.isNewUser) {
                  UiUtils.fetchBookmarkAndBadges(
                    context: context,
                    userId: state.userProfile.userId!,
                  );
                }
              },
              bloc: context.read<UserDetailsCubit>(),
              builder: (context, state) {
                if (state is UserDetailsFetchInProgress ||
                    state is UserDetailsInitial) {
                  return const Center(child: CircularProgressContainer());
                }
                if (state is UserDetailsFetchFailure) {
                  return ErrorContainer(
                    showBackButton: true,
                    errorMessage: convertErrorCodeToLanguageKey(
                      state.errorMessage,
                    ),
                    onTapRetry: () {
                      context.read<UserDetailsCubit>().fetchUserDetails();
                    },
                    showErrorImage: true,
                  );
                }

                final userProfile =
                    (state as UserDetailsFetchSuccess).userProfile;

                nameController ??= TextEditingController(
                  text: userProfile.name,
                );
                emailController ??= TextEditingController(
                  text: userProfile.email,
                );
                phoneController ??= TextEditingController(
                  text: userProfile.mobileNumber,
                );

                final size = context;

                // TODO(J): too many conditionals,
                //  separate isNewUser logic to one place.
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * .025),
                      Center(
                        child: _buildCurrentProfilePictureContainer(
                          image: selectedAvatar != null
                              ? selectedAvatar!
                              : selectedImage != null
                              ? selectedImage!.path
                              : userProfile.profileUrl ?? '',
                          isFile: selectedImage != null,
                          isAsset: selectedAvatar != null,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildSelectAvatarText(),
                      SizedBox(height: size.height * .025),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * UiUtils.hzMarginPct,
                        ),
                        child: _buildDefaultAvtarImages(),
                      ),
                      if (widget.args.isNewUser)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(color: Color(0xFF707070)),
                        )
                      else
                        const Divider(),
                      SizedBox(height: size.height * .02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * UiUtils.hzMarginPct,
                        ),
                        child: _buildNameTextFieldContainer(),
                      ),
                      SizedBox(height: size.height * .03),
                      if (!widget.args.isNewUser) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * UiUtils.hzMarginPct,
                          ),
                          child: _buildEmailTextFieldContainer(),
                        ),
                        SizedBox(height: size.height * .03),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * UiUtils.hzMarginPct,
                          ),
                          child: _buildPhoneTextFieldContainer(),
                        ),
                        SizedBox(height: size.height * .03),
                      ] else ...[
                        ..._buildNameAndReferCodeContainer(),
                      ],
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * UiUtils.hzMarginPct,
                        ),
                        child: _buildContinueButton(userProfile),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        ),
      ),
    );
  }
}
