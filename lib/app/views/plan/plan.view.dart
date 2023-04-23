import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/plan/plan.widgets.dart';
import 'package:assume/core/base/base_view/dynamic_base_view.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class PlanView extends DynamicBaseView with PlanWidgets {
  PlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: appBar(context),
      body: body(context),
      floatingActionButton: floatingActionButton(context),
    );
  }

  @override
  void initState(context) {
    if (!SystemCacheService.instance.getPermission()) {
      _savePermission();
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
                context.read<PlanViewModel>().oneShowCase,
                context.read<PlanViewModel>().twoShowCase,
                context.read<PlanViewModel>().threeShowCase
              ]));
    }
  }

  void _savePermission() async {
    await SystemCacheService.instance.savePermission(true);
  }

  @override
  void dispose(BuildContext context) {}
}
