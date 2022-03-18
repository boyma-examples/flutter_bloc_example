import 'package:flutter/material.dart';

Future showProgressCircle(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.white24.withOpacity(0.6),
    // Background color
    barrierDismissible: false,
    barrierLabel: 'Dialog',
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary),
        style: TextButton.styleFrom(
          primary: Colors.white24.withOpacity(0.6), // Background color
        ),
      );
    },
  );
}
