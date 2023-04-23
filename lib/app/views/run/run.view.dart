import 'package:assume/app/views/run/run.widgets.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

class RunView extends BaseView with RunWidgets {
  const RunView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: appBar(context),
      body: body(context),
    );
  }
}
