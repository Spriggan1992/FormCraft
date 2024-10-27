import 'package:flutter/material.dart';

class PersistentMask {
  final String maskPattern;
  final TextStyle? maskTextStyle;
  final TextStyle? inputTextStyle;

  PersistentMask({
    required this.maskPattern,
    required this.maskTextStyle,
    required this.inputTextStyle,
  });
}
