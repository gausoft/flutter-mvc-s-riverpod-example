import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String convertDate(DateTime date) {
  initializeDateFormatting();

  return DateFormat('yyyy-MM-dd hh:mm').format(date);
}

Future<bool> openConfirmDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
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
    },
  );
}
