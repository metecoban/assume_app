import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:assume/app/views/auth/sign_in/widgets/headline.widget.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/app/widgets/input/textFormField.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/alert_dialog.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/utils/validator/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key, this.isProfile});
  final bool? isProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: body(context),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            if (isProfile != null && isProfile == true) {
              Navigator.pop(context);
            } else {
              context.read<SignInViewModel>().pageController.animateToPage(2,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeInOut);
            }
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget body(BuildContext context) {
    final provider = Provider.of<SignInViewModel>(context);

    return Padding(
      padding: context.paddingNormal,
      child: SingleChildScrollView(
        child: Form(
          key: provider.newPasswordFormKey,
          child: Column(
            children: [
              HeadlineWidget(
                headline: context.l10n.newPasswordTitle,
                subHeadline: context.l10n.newPasswordSubTitle,
              ),
              Padding(
                padding: context.onlyBottomPaddingNormal,
                child: TextFormFieldWidget(
                  label: context.l10n.newPassword,
                  obscureText: provider.isObsecureNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  isPassword: true,
                  obscureTextOnPressed: () {
                    provider.changeIsObsecureNewPassword();
                  },
                  validator: FormValidator.passwordValidator,
                  controller: provider.newPasswordText,
                ),
              ),
              TextFormFieldWidget(
                label: context.l10n.confirmPassword,
                obscureText: provider.isObsecureNewPassword2,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (val) =>
                    isProfile != null && isProfile == true
                        ? provider.resetPasswordForProfile(context)
                        : provider.resetPassword(context),
                obscureTextOnPressed: () {
                  provider.changeIsObsecureNewPassword2();
                },
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return context.l10n.passwordBlankError;
                  } else if (p0 != provider.newPasswordText.text) {
                    return context.l10n.passwordMatchError;
                  }
                  return null;
                },
                controller: provider.newPasswordText2,
              ),
              Padding(
                padding: context.verticalPaddingNormal,
                child: ElevatedButtonWidget(
                    text: context.l10n.resetPassword,
                    onPressed: () {
                      isProfile != null && isProfile == true
                          ? provider.resetPasswordForProfile(context)
                          : provider.resetPassword(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> passwordRulesDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialogWidget(
            title: "Password rules",
            approveBtnName: 'Ok',
            content: context.l10n.allPasswordRules,
            approvePressed: () {
              Navigator.pop(context);
            });
      });
}
