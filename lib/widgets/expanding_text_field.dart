import 'package:flutter/material.dart';

class ExpandingTextField extends StatelessWidget {
  final TextEditingController controller;

  const ExpandingTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: 4,
        maxLength: 250,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        decoration: const InputDecoration(
          hintText: "What do you want?",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
          )
        ),
      ),
    );
  }
}