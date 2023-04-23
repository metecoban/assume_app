import 'package:assume/app/views/profile/profile.widgets.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends BaseView with ProfileWidgets {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: appBar(context),
      body: body(context),
    );
  }
}
