import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget(
      {super.key,
      this.bgColor,
      this.textColor,
      this.iconColor,
      required this.text,
      this.icon,
      this.onPressed,
      this.textStyle,
      this.isIconLeft});

  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final bool? isIconLeft;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: bgColor ?? context.color.transparent,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        textDirection:
            isIconLeft ?? false ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Text(text,
              style: textStyle != null
                  ? textStyle!.copyWith(
                      color: textColor ?? context.color.mainColor,
                    )
                  : context.textTheme.titleMedium!.copyWith(
                      color: textColor ??
                          Provider.of<ProfileViewModel>(context).currentColor,
                    )),
          if (icon != null)
            Padding(
              padding: context.horizontalPaddingNormal,
              child: Icon(
                icon,
                color: iconColor ?? context.color.mainColor,
              ),
            )
        ],
      ),
    );
  }
}
