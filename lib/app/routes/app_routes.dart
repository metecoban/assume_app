import 'package:assume/app/routes/routes.dart';
import 'package:assume/app/views/auth/sign_in/subview/new_password.view.dart';
import 'package:assume/app/views/auth/sign_in/sign_in.view.dart';
import 'package:assume/app/views/auth/sign_up/sign_up.view.dart';
import 'package:assume/app/views/done/done.view.dart';
import 'package:assume/app/views/home/home.view.dart';
import 'package:assume/app/views/onboarding/onboarding.view.dart';
import 'package:assume/app/views/permission/permission.view.dart';
import 'package:assume/app/views/profile/subview/app_settings.view.dart';
import 'package:assume/app/views/profile/subview/archive.view.dart';
import 'package:assume/app/views/profile/subview/statistic.view.dart';
import 'package:assume/app/views/profile/subview/user_settings.view.dart';
import 'package:assume/app/views/profile/profile.view.dart';
import 'package:assume/app/views/run/run.view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._init();
  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;

  Route<dynamic> onGenerateRoute(RouteSettings args) {
    final routes = Routes.values.byName(args.name!);
    return _buildPageRoute(routes);
  }

  PageRouteBuilder _buildPageRoute(Routes route) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        switch (route) {
          case Routes.onboarding:
            return const OnboardingView();
          case Routes.signIn:
            return const SignInView();
          case Routes.signUp:
            return const SignUpView();
          case Routes.permission:
            return const PermissionView();
          case Routes.home:
            return const HomeView();
          case Routes.run:
            return const RunView();
          case Routes.done:
            return const DoneView();
          case Routes.profile:
            return const ProfileView();
          case Routes.archive:
            return const ArchiveView();
          case Routes.statistic:
            return const StatisticView();
          case Routes.appSettings:
            return const AppSettingsView();
          case Routes.userSettings:
            return const UserSettingsView();
          case Routes.newPassword:
            return const NewPasswordView(
              isProfile: true,
            );
        }
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
