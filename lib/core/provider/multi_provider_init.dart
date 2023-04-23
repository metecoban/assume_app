import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:assume/app/views/auth/sign_up/sign_up.viewmodel.dart';
import 'package:assume/app/views/done/done.viewmodel.dart';
import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/app/views/onboarding/onboarding.viewmodel.dart';
import 'package:assume/app/views/permission/permission.viewmodel.dart';
import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/app/views/run/run.viewmodel.dart';
import 'package:assume/app/views/splash/splash.viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProviderInit {
  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => PlanViewModel()),
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ChangeNotifierProvider(create: (_) => SignInViewModel()),
    ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
    ChangeNotifierProvider(create: (_) => ProfileViewModel()),
    ChangeNotifierProvider(create: (_) => RunViewModel()),
    ChangeNotifierProvider(create: (_) => DoneViewModel()),
    ChangeNotifierProvider(create: (_) => SignUpViewModel()),
    ChangeNotifierProvider(create: (_) => PermissionViewModel()),
    ChangeNotifierProvider(create: (_) => SplashViewModel()),
  ];
}
