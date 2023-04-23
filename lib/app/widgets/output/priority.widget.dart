import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({
    super.key,
    required this.importance,
    required this.isChoosed,
  });

  final int importance;
  final bool isChoosed;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Icon(
        isChoosed == true ? Icons.circle_outlined : Icons.circle,
        color: context.color.mainColor
            .withOpacity(importance != 0 ? 0.2 * importance : 0.2 * 1),
        size: 25,
      ),
      Text(
        importance.toString(),
      )
    ]);
  }
}
