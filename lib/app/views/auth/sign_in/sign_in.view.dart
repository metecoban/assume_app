import 'package:assume/app/views/auth/sign_in/sign_in.widgets.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

class SignInView extends BaseView with SignInWidgets {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      body: body(context),
    );
  }
}
