import 'package:flutter/material.dart';
import 'package:flutter_form_craft/form_craft.dart';

class PersistentMask {
  final String maskPattern;
  final TextStyle? maskTextStyle;
  final TextStyle? inputTextStyle;
  final FormCraftValidator? validator;

  PersistentMask({
    required this.maskPattern,
    this.maskTextStyle,
    this.inputTextStyle,
    this.validator,
  });

  factory PersistentMask.defaultValidator({
    required String maskPattern,
    TextStyle? maskTextStyle,
    TextStyle? inputTextStyle,
    final String message = 'Invalid value',
  }) {
    return PersistentMask(
      maskPattern: maskPattern,
      maskTextStyle: maskTextStyle,
      inputTextStyle: inputTextStyle,
      validator: FormCraftValidator.custom(
          message: message,
          predicate: (input) => input!.length == maskPattern.length),
    );
  }
}
