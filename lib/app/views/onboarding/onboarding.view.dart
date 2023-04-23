import 'package:assume/app/views/onboarding/onboarding.widgets.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

class OnboardingView extends BaseView with OnboardingWidgets {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: appbar(context),
      body: body(context),
    );
  }
}
