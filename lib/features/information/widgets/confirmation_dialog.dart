import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  String title = 'Are you sure?',
  String? bodyText,
  String confirmText = 'Yes',
}) async {
  final response = await showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          bodyText ?? 'Are you sure you want to perform this operation?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );

  return response ?? false;
}
