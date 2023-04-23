import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/app/views/profile/widgets/menu_button.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/alert_dialog.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/show_alert_dialog.dart';
import 'package:assume/core/base/base_view/base_view.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AppSettingsView extends BaseView {
  const AppSettingsView({super.key});

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
        context.l10n.appSettings,
        style: context.textTheme.displaySmall,
      ),
    );
  }

  Column _body(BuildContext context) {
    ProfileViewModel provider = context.read<ProfileViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuButtonWidget(
          name: context.l10n.language,
          icon: Icons.language,
          onPressed: () {
            showAlertDialog(
                context,
                AlertDialogWidget(
                  title: context.l10n.language,
                  contentWidget: SizedBox(
                    height: context.dynamicHeight(0.2),
                    width: 250,
                    child: ListView.builder(
                        itemCount: provider.languages.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () => provider.changeRadioValue(index),
                                child: Text(
                                  provider.languages[index],
                                  style: context.textTheme.displaySmall,
                                ),
                              ),
                              Radio(
                                activeColor: context.color.mainColor,
                                value: index,
                                groupValue: context
                                    .watch<ProfileViewModel>()
                                    .radioValue,
                                onChanged: (value) =>
                                    provider.changeRadioValue(index),
                              ),
                            ],
                          );
                        }),
                  ),
                  approveBtnName: context.l10n.save,
                  approvePressed: () {
                    provider.languageCode = Locale(L10n
                        .supportedLocales[provider.radioValue].languageCode);

                    Navigator.of(context).pop();
                  },
                  cancelPressed: () {
                    Navigator.of(context).pop();
                  },
                ));
          },
        ),
        MenuButtonWidget(
          name: context.l10n.notification,
          icon: Icons.notifications_outlined,
          onPressed: () {
            showAlertDialog(
                context,
                AlertDialogWidget(
                  title: context.l10n.notification,
                  content: context.l10n.changeNotification,
                  approveBtnName: context.l10n.goSettings,
                  approvePressed: () {
                    openAppSettings();
                  },
                  cancelPressed: () {
                    Navigator.of(context).pop();
                  },
                ));
          },
        ),
        MenuButtonWidget(
          name: context.l10n.mainColor,
          icon: Icons.palette_outlined,
          onPressed: () {
            _mainColorPicker(context, provider);
          },
        ),
        MenuButtonWidget(
            name: context.l10n.theme,
            icon: Icons.nightlight_outlined,
            onPressed: () {
              provider.changeSwitchValue(!provider.switchValue);
            },
            trailing: Switch(
              activeColor: context.color.mainColor,
              value: context.watch<ProfileViewModel>().switchValue,
              onChanged: (value) => provider.changeSwitchValue(value),
            ))
      ],
    );
  }

  Future<dynamic> _mainColorPicker(
      BuildContext context, ProfileViewModel provider) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          title: context.l10n.chooseColor,
          contentWidget: BlockPicker(
              pickerColor: provider.currentColor,
              onColorChanged: provider.changeCurrentColor,
              availableColors: context.color.colorList()),
          approveBtnName: context.l10n.change,
          approvePressed: () {
            provider.changeMainColor();
            Navigator.of(context).pop();
          },
          cancelPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
