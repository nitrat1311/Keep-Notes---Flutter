import 'package:flutter/material.dart';

class TextFrave extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isTitle;
  final FontWeight fontWeight;
  final Color color;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final double? letterSpacing;

  const TextFrave({
    Key? key,
    required this.text,
    this.fontSize = 24,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.maxLines = 1,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.center,
    this.letterSpacing,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
