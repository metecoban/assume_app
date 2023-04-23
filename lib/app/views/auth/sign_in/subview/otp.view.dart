import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:assume/app/views/auth/sign_in/widgets/headline.widget.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/core/constants/color_constants.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});

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
            context.read<SignInViewModel>().pageController.animateToPage(1,
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeInOut);
            context.read<SignInViewModel>().otpText = TextEditingController();
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget body(BuildContext context) {
    final provider = Provider.of<SignInViewModel>(context);

    return Padding(
      padding: context.paddingNormal,
      child: SingleChildScrollView(
        child: Column(
          children: [
             HeadlineWidget(
              headline: context.l10n.otpTitle,
              subHeadline: context.l10n.otpSubTitle,
            ),
            Padding(
              padding: context.horizontalPaddingMedium,
              child: PinCodeTextField(
                length: 4,
                animationType: AnimationType.fade,
                cursorColor: ColorConstant.instance.red,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  activeColor: ColorConstant.instance.red,
                  selectedColor: Colors.black,
                  selectedFillColor: ColorConstant.instance.light,
                  inactiveFillColor: ColorConstant.instance.light,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                appContext: context,
                onCompleted: (v) {
                  provider.otpControl(context);
                },
                onChanged: (value) {
                  provider.otpText.text = value;
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
            ),
            Padding(
              padding: context.verticalPaddingNormal,
              child: ElevatedButtonWidget(
                  text: context.l10n.verify,
                  onPressed: () {
                    provider.otpControl(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
