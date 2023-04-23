import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/routes/routes.dart';
import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:assume/app/views/auth/sign_in/sign_in.widgets.dart';
import 'package:assume/app/views/auth/sign_in/widgets/headline.widget.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/app/widgets/button/textButton.widget.dart';
import 'package:assume/app/widgets/input/textFormField.widget.dart';
import 'package:assume/core/constants/color_constants.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/utils/validator/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget with SignInWidgets {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: body(context),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar();
  }

  @override
  Widget body(BuildContext context) {
    final provider = Provider.of<SignInViewModel>(context);

    return Padding(
      padding: context.paddingNormal,
      child: SingleChildScrollView(
        child: Form(
          key: provider.loginFormKey,
          child: Column(
            children: [
              HeadlineWidget(
                headline: context.l10n.loginTitle,
                subHeadline: context.l10n.loginSubTitle,
              ),
              TextFormFieldWidget(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                controller: provider.emailText,
                label: context.l10n.email,
                validator: FormValidator.emailValidator,
              ),
              Padding(
                padding: context.verticalPaddingNormal,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (string) => provider.login(context),
                      keyboardType: TextInputType.visiblePassword,
                      controller: provider.passwordText,
                      label: context.l10n.password,
                      obscureText: provider.isObsecure,
                      isPassword: true,
                      obscureTextOnPressed: () {
                        provider.changeIsObsecure();
                      },
                      validator: FormValidator.passwordValidator,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButtonWidget(
                          onPressed: () {
                            context
                                .read<SignInViewModel>()
                                .pageController
                                .animateToPage(1,
                                    duration: const Duration(milliseconds: 750),
                                    curve: Curves.easeInOut);
                          },
                          textStyle: context.textTheme.titleMedium,
                          text: context.l10n.forgotPassword,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButtonWidget(
                  text: context.l10n.signIn,
                  onPressed: () {
                    provider.login(context);
                  }),
              _horizontalDivider(context),
              _authenticationSide(context, provider),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.l10n.dontHaveAccount,
                      style: context.textTheme.titleMedium),
                  Padding(
                    padding: context.verticalPaddingLow,
                    child: TextButtonWidget(
                        text: context.l10n.signUp,
                        onPressed: () async {
                          NavigationService.instance
                              .navigateToPage(path: Routes.signUp.name);
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _authenticationSide(BuildContext context, SignInViewModel provider) {
    return ElevatedButtonWidget(
      onPressed: () {
        provider.loginWithAuth(context);
      },
      bgColor: ColorConstant.instance.blue,
      text: context.l10n.google,
      icon: const FaIcon(FontAwesomeIcons.google),
    );
  }

  Widget _horizontalDivider(BuildContext context) {
    return Padding(
      padding: context.verticalPaddingMedium,
      child: Row(children: <Widget>[
        const Expanded(child: Divider(thickness: 2)),
        Padding(
          padding: context.horizontalPaddingNormal,
          child: Text(context.l10n.or),
        ),
        const Expanded(child: Divider(thickness: 2)),
      ]),
    );
  }
}
