import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/app/routes/app_routes.dart';
import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/views/splash/splash.view.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/init/theme/custom_theme.dart';
import 'package:assume/core/provider/multi_provider_init.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssumeApp extends StatelessWidget {
  const AssumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: MultiProviderInit().providers,
        builder: (context, child) {
          return MaterialApp(
            home: const SplashView(),
            title: "Assume",
            themeMode: context.themeMode,
            theme: CustomTheme.theme(brightness: Brightness.light),
            darkTheme: CustomTheme.theme(brightness: Brightness.dark),
            locale: context.locale,
            localizationsDelegates: L10n.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.instance.onGenerateRoute,
            navigatorKey: NavigationService.instance.navigatorKey,
          );
        });
  }
}
