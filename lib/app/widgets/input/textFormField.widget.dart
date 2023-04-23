import 'package:assume/app/views/auth/sign_in/subview/new_password.view.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.obscureText,
    this.obscureTextOnPressed,
    this.isPassword,
    this.prefixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.enabled,
    this.autofocus = false,
    this.onFieldSubmitted,
  });
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool? obscureText;
  final bool? isPassword;
  final VoidCallback? obscureTextOnPressed;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: autofocus,
        enabled: enabled,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType,
        autovalidateMode:
            autovalidateMode ?? AutovalidateMode.onUserInteraction,
        validator: validator,
        obscureText: obscureText ?? false,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: isPassword == true
                ? IconButton(
                    color: context.color.mainColor,
                    icon: const Icon(Icons.lock),
                    onPressed: () {
                      passwordRulesDialog(context);
                    },
                  )
                : prefixIcon,
            suffixIcon: isPassword == true
                ? IconButton(
                    padding: context.onlyRightPaddingNormal,
                    onPressed: obscureTextOnPressed,
                    color: context.color.mainColor,
                    icon: Icon(obscureText ?? false
                        ? Icons.visibility
                        : Icons.visibility_off))
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            label: Text(label)));
  }
}
