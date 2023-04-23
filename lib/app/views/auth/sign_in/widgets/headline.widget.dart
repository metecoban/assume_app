import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  const HeadlineWidget({
    super.key,
    required this.headline,
    required this.subHeadline,
  });

  final String headline;
  final String subHeadline;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.25),
      child: Padding(
        padding: context.verticalPaddingNormal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              headline,
              style: context.textTheme.displayMedium,
            ),
            Padding(
              padding: context.verticalPaddingNormal,
              child: Text(
                subHeadline,
                style: context.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
