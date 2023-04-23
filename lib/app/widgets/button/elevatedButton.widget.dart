import 'package:assume/core/constants/color_constants.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    this.bgColor,
    required this.text,
    required this.onPressed,
    this.icon,
    this.textColor,
    this.iconColor,
  });

  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;
  final String text;
  final Widget? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(width: 1.2),
        shape: context.roundedRectangleBorder,
        backgroundColor: bgColor ?? context.color.mainColor,
      ),
      child: SizedBox(
        height: context.dynamicHeight(0.053),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                  style: context.textTheme.titleLarge!.copyWith(
                    color: textColor ?? ColorConstant.instance.light,
                  )),
              if (icon != null)
                Padding(
                  padding: context.horizontalPaddingLow,
                  child: icon.runtimeType == IconData
                      ? Icon(
                          icon as IconData,
                          color: iconColor ?? ColorConstant.instance.light,
                        )
                      : icon,
                )
            ],
          ),
        ),
      ),
    );
  }
}
