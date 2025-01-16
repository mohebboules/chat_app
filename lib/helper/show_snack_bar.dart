import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
  Color? color,
}) {
  final SnackBar snackBar = SnackBar(
    backgroundColor: color ?? Colors.red,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
