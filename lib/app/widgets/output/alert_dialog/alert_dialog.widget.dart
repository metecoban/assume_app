import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    Key? key,
    required this.title,
    this.content,
    this.approvePressed,
    this.cancelPressed,
    this.extraPressed,
    this.extraBtnName,
    this.approveBtnName,
    this.contentWidget,
  }) : super(key: key);

  final String title;
  final String? content;
  final Widget? contentWidget;
  final VoidCallback? approvePressed;
  final VoidCallback? cancelPressed;
  final VoidCallback? extraPressed;
  final String? extraBtnName;
  final String? approveBtnName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: context.textTheme.displaySmall),
      content: contentWidget ?? (content != null ? Text(content!) : null),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (extraBtnName != null)
                ? TextButton(
                    onPressed: extraPressed,
                    child: Text(
                      extraBtnName!,
                      style: TextStyle(
                        color: context.color.mainColor,
                      ),
                    ),
                  )
                : const SizedBox(),
            Row(
              children: [
                if (cancelPressed != null)
                  TextButton(
                    onPressed: cancelPressed,
                    child: Text(
                      context.l10n.cancel,
                      style: TextStyle(
                        color: context.color.mainColor,
                      ),
                    ),
                  ),
                if (approvePressed != null)
                  TextButton(
                    onPressed: approvePressed,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        context.color.mainColor,
                      ),
                    ),
                    child: Text(
                      approveBtnName ?? context.l10n.approve,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
              ],
            )
          ],
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 24,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
    );
  }
}
