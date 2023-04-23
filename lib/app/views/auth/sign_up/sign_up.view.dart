import 'package:assume/app/views/auth/sign_up/sign_up.widgets.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

class SignUpView extends BaseView with SignUpWidgets {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: appbar(),
      body: body(context),
    );
  }
}
