import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/routes/routes.dart';
import 'package:assume/app/views/permission/permission.viewmodel.dart';
import 'package:assume/app/widgets/button/elevatedButton.widget.dart';
import 'package:assume/app/widgets/button/textButton.widget.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermissionWidgets {
  Widget body(BuildContext context) {
    final provider = Provider.of<PermissionViewModel>(context);

    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: context.horizontalPaddingMedium,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: context.verticalPaddingNormal,
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Image.asset(Assets.images.notification.path),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          context.l10n.notificationPermission,
                          style: context.textTheme.headlineLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: context.paddingNormal,
              child: ElevatedButtonWidget(
                  text: context.l10n.allowNotification,
                  onPressed: () {
                    provider.requestNotificationPermission();
                  }),
            ),
            SizedBox(
              height: context.dynamicHeight(0.05),
            ),
          ]),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      actions: [
        TextButtonWidget(
            text: context.l10n.later,
            onPressed: () {
              NavigationService.instance
                  .navigateToPageClear(path: Routes.home.name);
            })
      ],
    );
  }
}
