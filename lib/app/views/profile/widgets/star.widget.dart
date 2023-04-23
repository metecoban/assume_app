import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/app/widgets/output/alert_dialog/alert_dialog.widget.dart';
import 'package:assume/app/widgets/output/alert_dialog/show_alert_dialog.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class StarWidget extends StatefulWidget {
  const StarWidget({super.key, required this.badgeCount});
  final int badgeCount;

  @override
  // ignore: library_private_types_in_public_api
  _StarWidgetState createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _animation =
        Tween<double>(begin: 0.0, end: 2.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(2, 3, 0.001)
          ..rotateY(_animation.value * 3.141592),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          InkWell(
            onTap: () => _starOnTap(context),
            child: Icon(
              Icons.star,
              size: context.dynamicHeight(0.2),
              color: context.color.mainColor,
            ),
          ),
          Center(
            child: InkWell(
              onTap: () => _starOnTap(context),
              child: SizedBox(
                height: context.dynamicHeight(0.065),
                width: context.dynamicWidth(0.19),
                child: FittedBox(
                  child: Text(widget.badgeCount.toString(),
                      style: context.textTheme.displayLarge!
                          .copyWith(color: context.color.light)),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _starOnTap(BuildContext context) {
    _animationController.reset();
    _animationController.forward();

    showAlertDialog(
        context,
        AlertDialogWidget(
          title:
              '${context.l10n.starAlertTitle} ${context.read<ProfileViewModel>().badgeCount} ${context.read<ProfileViewModel>().badgeCount > 1 ? 'days' : 'day'}',
          content: context.l10n.starAlertContent,
          approveBtnName: context.l10n.ok,
          approvePressed: () => Navigator.pop(context),
          extraBtnName: context.l10n.share,
          extraPressed: () {
            Share.share(
              '${context.l10n.shareDialogFront} ${context.read<ProfileViewModel>().badgeCount} ${context.l10n.shareDialogEnd}',
            );
          },
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
