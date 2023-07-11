import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final TextEditingController controller;

  const TextTitle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
            contentPadding: EdgeInsets.only(left: 10.0)),
      ),
    );
  }
}
