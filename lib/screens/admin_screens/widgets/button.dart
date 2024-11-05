import 'package:flutter/material.dart';

Widget button(String title, Function() onPressed) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        const Color.fromARGB(255, 226, 142, 103),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      minimumSize: WidgetStateProperty.all<Size>(
        const Size(double.infinity, 50),
      ),
    ),
    onPressed: onPressed,
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
