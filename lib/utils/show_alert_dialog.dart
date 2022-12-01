import 'package:flutter/material.dart';

Future showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      });
}
