import 'package:flutter/material.dart';

class EnabledWidget extends StatelessWidget {
  const EnabledWidget({super.key, required this.child, this.enabled = true});
  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () {} : null,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Opacity(
          opacity: enabled ? 1.0 : 0.5,
          child: child,
        ),
      ),
    );
  }
}
