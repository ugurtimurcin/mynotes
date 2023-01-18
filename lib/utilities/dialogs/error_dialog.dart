import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    icon: const Icon(Icons.error, color: Colors.redAccent),
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
