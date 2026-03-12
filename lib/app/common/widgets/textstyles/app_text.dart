import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const AppText._({
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  factory AppText.header(String text, Color? color) => AppText._(
    text: text,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: color,
  );

  //title - body
  factory AppText.title(String text, Color? color) => AppText._(
    text: text,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: color,
  );

  factory AppText.body(String text, Color? color) => AppText._(
    text: text,
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(Object context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w800,
      ),
    );
  }
}