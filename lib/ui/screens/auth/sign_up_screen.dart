import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/widgets/custom_snackbar.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/auth/auth_repository.dart';
import 'package:ebeere/features/auth/cubits/sign_up_cubit.dart';
import 'package:ebeere/features/auth/models/auth_providers_enum.dart';
        builder: (_) => Scaffold(
          body: DecoratedBackground(
            shapesCount: 20,
            shapesSeed: 456,
            child: SingleChildScrollView(
              child: form(),
            ),
          ),
        ),
      ),
    );
  }

  Widget form() {
    final size = context;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * UiUtils.vtMarginPct,
          horizontal: size.shortestSide * UiUtils.hzMarginPct + 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size.height * .07),
            Row(
              children: [
                InkWell(
                  onTap: Navigator.of(context).pop,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 24,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * .02),
            const AppLogo(),
            SizedBox(height: size.height * .08),
            EmailTextField(controller: emailController),
            SizedBox(height: size.height * .02),
            PswdTextField(controller: pswdController),
            SizedBox(height: size.height * .02),
            PswdTextField(
              controller: confirmPswdController,
              hintText: "${context.tr("cnPwdLbl")!}*",
              validator: (val) {
                if (val != pswdController.text) {
                  return context.tr('cnPwdNotMatchMsg');
                }
                return null;
              },
            ),
            SizedBox(height: size.height * .04),
            signupButton(),
            SizedBox(height: size.height * .02),
            showGoSignIn(),
            SizedBox(height: size.height * .04),
            const TermsAndCondition(),
          ],
        ),
      ),
    );
  }

  Widget showGoSignIn() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.tr('alreadyAccountLbl')!,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(
              context,
            ).colorScheme.onTertiary.withValues(alpha: 0.4),
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: Navigator.of(context).pop,
          child: Text(
            context.tr('loginLbl')!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeights.regular,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget signupButton() {
    return Column(
      children: [
        SizedBox(
          width: context.width,
          height: context.height * 0.055,
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) async {
              if (state is SignUpSuccess) {
                //on signup success navigate user to sign in screen
                context.showSnack(
                  "${context.tr('emailVerify')} $userEmail",
                );
                setState(() {
                  Navigator.pop(context);
                });
              } else if (state is SignUpFailure) {
                //show error message
                context.showSnack(
                  context.tr(
                    convertErrorCodeToLanguageKey(state.errorMessage),
                  )!,
                );
              }
            },
            builder: (context, state) {
              return CupertinoButton(
                padding: const EdgeInsets.all(5),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //calling signup user
                    context.read<SignUpCubit>().signUpUser(
                      AuthProviders.email,
                      emailController.text.trim(),
                      pswdController.text.trim(),
                    );
                    userEmail = emailController.text.trim();
                    resetForm();
                  }
                },
                child: state is SignUpProgress
                    ? const Center(
                        child: CircularProgressContainer(whiteLoader: true),
                      )
                    : Text(
                        context.tr('signUpLbl')!,
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  void resetForm() {
    setState(() {
      isLoading = false;
      emailController.text = '';
      pswdController.text = '';
      confirmPswdController.text = '';
      _formKey.currentState!.reset();
    });
  }
}
