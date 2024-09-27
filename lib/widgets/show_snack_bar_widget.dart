import 'package:flutter/material.dart';

showSnackBarMessage(
    {required BuildContext context,
    required String message,
    required bool isSuccess}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 700),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
