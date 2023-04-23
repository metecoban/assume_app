import 'package:assume/app/views/permission/permission.widgets.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

class PermissionView extends BaseView with PermissionWidgets {
  const PermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: appbar(context),
      body: body(context),
    );
  }
}
