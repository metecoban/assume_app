import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChevronDateWidget extends StatelessWidget {
  const ChevronDateWidget({
    super.key,
    required this.date,
    this.onPressedLeftChevron,
    this.onPressedRightChevron,
  });
  final DateTime date;
  final VoidCallback? onPressedLeftChevron;
  final VoidCallback? onPressedRightChevron;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: onPressedLeftChevron,
              icon: const Icon(Icons.chevron_left)),
          Text(DateFormat('yyyy-MM-dd').format(date).toString(),
              style: context.textTheme.labelLarge!),
          IconButton(
              onPressed: onPressedRightChevron,
              icon: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
