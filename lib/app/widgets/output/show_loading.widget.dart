import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

showCircularProgress(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => Center(
            child: CircularProgressIndicator(
              color: context.color.mainColor,
            ),
          ));
}
