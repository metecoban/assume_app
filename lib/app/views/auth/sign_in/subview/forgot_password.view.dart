import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:assume/app/views/auth/sign_in/widgets/headline.widget.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/app/widgets/button/textButton.widget.dart';
import 'package:assume/app/widgets/input/textFormField.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/utils/validator/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
            context.read<SignInViewModel>().pageController.animateToPage(0,
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeInOut);
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget body(BuildContext context) {
    final provider = Provider.of<SignInViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingNormal,
        child: Form(
          key: provider.forgotPasswordFormKey,
          child: Column(
            children: [
              HeadlineWidget(
                headline: context.l10n.forgotPasswordTitle,
                subHeadline: context.l10n.forgotPasswordSubTitle,
              ),
              TextFormFieldWidget(
                prefixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (val) => provider.sendCode(context),
                label: context.l10n.email,
                validator: FormValidator.emailValidator,
                controller: provider.resetEmailText,
              ),
              Padding(
                padding: context.verticalPaddingNormal,
                child: ElevatedButtonWidget(
                    text: context.l10n.sendCode,
                    onPressed: () {
                      provider.sendCode(context);
                    }),
              ),
              TextButtonWidget(
                  text: context.l10n.alreadySendCode,
                  onPressed: () {
                    context
                        .read<SignInViewModel>()
                        .pageController
                        .animateToPage(2,
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.easeInOut);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
