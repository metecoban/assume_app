import 'package:assume/app/views/home/home.view.dart';
import 'package:assume/app/views/onboarding/onboarding.view.dart';
import 'package:assume/app/views/splash/splash.viewmodel.dart';
import 'package:assume/app/views/splash/splash.widgets.dart';
import 'package:assume/core/base/base_view/dynamic_base_view.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends DynamicBaseView with SplashWidgets {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(context, body: body(context));
  }

  @override
  void dispose(BuildContext context) {}

  @override
  void initState(BuildContext context) {
    _init(context);
  }

  _init(BuildContext context) async {
    await context.read<SplashViewModel>().fetchData().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserCacheService.instance.getUserID() == null
                      ? const OnboardingView()
                      : const HomeView()));
    });
  }
}
