import 'package:flutter/material.dart';

class TextWriteNote extends StatelessWidget {
  final TextEditingController controller;

  const TextWriteNote({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        controller: controller,
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Write a note...',
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
