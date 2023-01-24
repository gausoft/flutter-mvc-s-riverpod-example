import 'package:flutter/material.dart';

class DeteleItemDialog extends StatelessWidget {
  const DeteleItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Detele item"),
      content: const Text("Are you sure you wish to delete this item?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("DELETE"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("CANCEL"),
        ),
      ],
    );
  }
}
