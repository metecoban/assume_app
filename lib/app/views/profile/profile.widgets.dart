import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/routes/routes.dart';
import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/app/views/profile/widgets/menu_button.widget.dart';
import 'package:assume/app/views/profile/widgets/star.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/alert_dialog.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/show_alert_dialog.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/user/request/user_request.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/auth/register/register_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileWidgets {
  Widget body(BuildContext context) {
    context.read<ProfileViewModel>().controlToBadge();
    UserRequest user = UserCacheService.instance.getUser();
    bool isAnonymous = user.email == null ? true : false;
    return SingleChildScrollView(
      child: Padding(
        padding: context.verticalPaddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _starBadge(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuButtonWidget(
                  name: context.l10n.archives,
                  icon: Icons.archive,
                  onPressed: () => NavigationService.instance
                      .navigateToPage(path: Routes.archive.name),
                ),
                MenuButtonWidget(
                  name: context.l10n.statistics,
                  icon: Icons.bar_chart,
                  onPressed: () => NavigationService.instance
                      .navigateToPage(path: Routes.statistic.name),
                ),
                MenuButtonWidget(
                  name: context.l10n.userSettings,
                  icon: Icons.person,
                  onPressed: () => NavigationService.instance
                      .navigateToPage(path: Routes.userSettings.name),
                ),
                MenuButtonWidget(
                  name: context.l10n.appSettings,
                  icon: Icons.settings,
                  onPressed: () => NavigationService.instance
                      .navigateToPage(path: Routes.appSettings.name),
                ),
                MenuButtonWidget(
                  name: context.l10n.privacy,
                  icon: Icons.handshake,
                  onPressed: () => _launchURL(context),
                ),
                MenuButtonWidget(
                  name: context.l10n.logOut,
                  icon: Icons.logout_outlined,
                  onPressed: () => _logOut(context, isAnonymous),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _logOut(BuildContext context, bool isAnonymous) {
    showAlertDialog(
        context,
        AlertDialogWidget(
          title: context.l10n.logOutAlertTitle,
          extraBtnName: isAnonymous ? context.l10n.signUp : null,
          extraPressed: () {
            Navigator.pop(context);
            NavigationService.instance.navigateToPage(path: Routes.signUp.name);
          },
          approveBtnName:
              isAnonymous ? context.l10n.delete : context.l10n.approve,
          content: isAnonymous ? context.l10n.logOutAlertContent : null,
          approvePressed: isAnonymous
              ? () {
                  RegisterService.instance.deleteUser(deleteAuthToo: true);
                  NavigationService.instance
                      .navigateToPageClear(path: Routes.onboarding.name);
                  context.read<HomeViewModel>().clear();
                }
              : () {
                  context.read<ProfileViewModel>().logOut(context);
                },
          cancelPressed: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget _starBadge(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: context.color.mainColor, width: 2),
              shape: BoxShape.circle),
          height: context.dynamicHeight(0.2),
          child: StarWidget(
            badgeCount: context.read<ProfileViewModel>().badgeCount,
          ),
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${((UserCacheService.instance.getUser() as UserRequest).name ?? context.l10n.anonymous).toUpperCase()} ${((UserCacheService.instance.getUser() as UserRequest).surname ?? "").toUpperCase()}',
                style: context.textTheme.titleLarge,
              ),
              IconButton(
                  onPressed: () => Share.share(
                        '${context.l10n.shareDialogFront} ${context.read<ProfileViewModel>().badgeCount} ${context.l10n.shareDialogEnd}',
                      ),
                  icon: const Icon(Icons.share))
            ],
          ),
        )
      ],
    ));
  }

  _launchURL(BuildContext context) async {
    String url = context.l10n.privacyLink;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // ignore: use_build_context_synchronously
      throw '${context.l10n.privacyLinkError} $url';
    }
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.profile,
        style: context.textTheme.displayMedium,
      ),
    );
  }
}
