import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    super.key,
    this.onPressed,
    this.trailing = const Icon(
      Icons.arrow_forward_ios,
      size: 17,
    ),
    this.icon = Icons.settings,
    this.name = 'Button',
  });
  final VoidCallback? onPressed;
  final Widget trailing;
  final IconData icon;
  final String name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: context.verticalPaddingNormal,
        child: Padding(
          padding: context.horizontalPaddingMedium,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 15,
                children: [
                  Icon(icon),
                  Text(name, style: context.textTheme.labelLarge),
                ],
              ),
              SizedBox(height: 20, child: trailing)
            ],
          ),
        ),
      ),
    );
  }
}
