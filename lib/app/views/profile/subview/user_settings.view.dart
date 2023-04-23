import 'package:assume/app/routes/routes_widgets.dart';
import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/app/views/profile/widgets/menu_button.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/alert_dialog.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/show_alert_dialog.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/auth/register/register_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSettingsView extends BaseView {
  const UserSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return dynamicBuild(
      context,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.userSettings,
        style: context.textTheme.displaySmall,
      ),
    );
  }

  Column _body(BuildContext context) {
    HomeViewModel provider = context.read<HomeViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuButtonWidget(
          name: context.l10n.changePassword,
          icon: Icons.lock_outline,
          onPressed: () {
            if (UserCacheService.instance.getUser().email != null) {
              NavigationService.instance
                  .navigateToPage(path: Routes.newPassword.name);
            } else {
              showAlertDialog(
                  context,
                  AlertDialogWidget(
                    title: context.l10n.anonymousUser,
                    content: context.l10n.cantChangePassword,
                    approveBtnName: context.l10n.ok,
                    approvePressed: () => Navigator.pop(context),
                  ));
            }
          },
        ),
        MenuButtonWidget(
          name: context.l10n.deleteAccount,
          icon: Icons.delete_forever_outlined,
          onPressed: () {
            showAlertDialog(
                context,
                AlertDialogWidget(
                  title: context.l10n.deleteAlertTitle,
                  content: context.l10n.deleteAlertContent,
                  approveBtnName: context.l10n.delete,
                  approvePressed: () async {
                    provider.changeIsLoading(context);
                    await RegisterService.instance
                        .deleteUser(deleteAuthToo: true)
                        .then((value) => provider.changeIsLoading(context));
                    NavigationService.instance
                        .navigateToPageClear(path: Routes.onboarding.name);
                    provider.clear();
                  },
                  cancelPressed: () => Navigator.pop(context),
                ));
          },
        ),
      ],
    );
  }
}
