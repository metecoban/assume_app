import 'package:assume/app/views/plan/plan.widgets.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class TitleAndValueWidget extends StatelessWidget {
  const TitleAndValueWidget({
    super.key,
    required this.value,
    required this.title,
  });
  final String title;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        menuLabel(context, title),
        Padding(
          padding: context.onlyLeftPaddingLow,
          child: value,
        )
      ],
    );
  }
}