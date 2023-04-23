import 'package:assume/app/views/done/done.widgets.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

class DoneView extends BaseView with DoneWidgets {
  const DoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: appBar(context),
      body: body(context),
    );
  }
}
