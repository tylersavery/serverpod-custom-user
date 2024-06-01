import 'package:flutter/material.dart';

Future<String?> textPrompt(
  BuildContext context, {
  required String title,
  String? initialValue,
}) async {
  final controller = TextEditingController(text: initialValue);

  final String? value = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: const Text("Okay"),
          )
        ],
      );
    },
  );

  return value;
}
