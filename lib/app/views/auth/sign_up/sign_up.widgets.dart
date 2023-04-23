import 'package:assume/app/views/auth/sign_in/widgets/headline.widget.dart';
import 'package:assume/app/views/auth/sign_up/sign_up.viewmodel.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/app/widgets/button/textButton.widget.dart';
import 'package:assume/app/widgets/input/textFormField.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/utils/validator/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpWidgets {
  AppBar appbar() => AppBar();

  Widget body(BuildContext context) {
    final provider = Provider.of<SignUpViewModel>(context);

    return Padding(
      padding: context.paddingNormal,
      child: SingleChildScrollView(
        child: Form(
          key: provider.signUpFormKey,
          child: Column(
            children: [
              HeadlineWidget(
                  headline: context.l10n.signUp,
                  subHeadline: context.l10n.signUpSubTitle),
              TextFormFieldWidget(
                prefixIcon: const Icon(Icons.person),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                controller: provider.nameText,
                label: context.l10n.fullName,
                validator: FormValidator.fullNameValidator,
              ),
              Padding(
                padding: context.onlyTopPaddingNormal,
                child: TextFormFieldWidget(
                  prefixIcon: const Icon(Icons.email),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: provider.emailText,
                  label: context.l10n.email,
                  validator: FormValidator.emailValidator,
                ),
              ),
              Padding(
                padding: context.verticalPaddingNormal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormFieldWidget(
                      controller: provider.passwordText,
                      label: context.l10n.password,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (val) => provider.addUser(context),
                      obscureText: provider.isObsecure,
                      isPassword: true,
                      obscureTextOnPressed: () {
                        provider.changeIsObsecure();
                      },
                      validator: FormValidator.passwordValidator,
                    ),
                  ],
                ),
              ),
              ElevatedButtonWidget(
                  text: context.l10n.signUp,
                  onPressed: () {
                    provider.addUser(context);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.l10n.alreadyHaveAccount,
                      style: context.textTheme.titleMedium),
                  Padding(
                    padding: context.verticalPaddingLow,
                    child: TextButtonWidget(
                        text: context.l10n.signIn,
                        onPressed: () {
                          Navigator.of(context).pop();
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
}
