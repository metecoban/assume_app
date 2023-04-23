import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class DynamicBaseView extends StatefulWidget {
  const DynamicBaseView({Key? key}) : super(key: key);

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
      Scaffold(body: SafeArea(child: body));

  Widget build(BuildContext context);
  void initState(BuildContext context);
  void dispose(BuildContext context);

  @override
  // ignore: library_private_types_in_public_api
  _DynamicBaseViewState createState() => _DynamicBaseViewState();
}

class _DynamicBaseViewState extends State<DynamicBaseView> {
  @override
  void initState() {
    widget.initState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  @override
  void dispose() {
    widget.dispose(context);
    super.dispose();
  }
}
