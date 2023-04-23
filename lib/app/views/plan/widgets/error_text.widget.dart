import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget(
      {super.key, required this.child, this.hasError, this.errorText});
  final Widget child;
  final bool? hasError;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (hasError ?? false)
          Padding(
            padding: const EdgeInsets.only(top: 7, left: 15),
            child: Text(
              errorText ?? context.l10n.error,
              style: context.textTheme.labelMedium!.copyWith(color: Colors.red),
            ),
          )
      ],
    );
  }
}
