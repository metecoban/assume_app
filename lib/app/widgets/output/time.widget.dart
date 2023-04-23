import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.time,
    required this.text,
  });
  final String time;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.color.mainColor,
      radius: context.dynamicWidth(0.070),
      child: FittedBox(
        child: Column(children: [
          FittedBox(
            child: Text(
              time,
              style: TextStyle(
                fontSize: context.dynamicWidth(0.08),
                color: context.color.light,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FittedBox(
            child: Text(
              text,
              style: TextStyle(
                fontSize: context.dynamicWidth(0.0365),
                color: context.color.light,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
