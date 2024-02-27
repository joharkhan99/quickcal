import 'package:flutter/material.dart';

class AlertMessage {
  AlertMessage(BuildContext context, String title, String content, {bool isError = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                isError ? Icons.error : Icons.info,
                color: isError ? Colors.red : Colors.blue,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[400],
              ),
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }
}
