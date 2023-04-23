import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseView extends StatelessWidget {
  const BaseView({super.key});

  Widget dynamicBuild(
    BuildContext context, {
    required Widget body,
    Widget? bottomNavigationBar,
    PreferredSizeWidget? appBar,
    FloatingActionButton? floatingActionButton,
  }) =>
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          appBar: appBar,
          floatingActionButton: floatingActionButton,
        ),
      );

  Widget errorBuild(BuildContext context, {required Widget body}) =>
      SafeArea(child: Scaffold(body: body));
}
