import 'package:flutter/material.dart';

Widget inputField(
  TextEditingController controller,
  String hint, {
  TextInputType? keyboard,
}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return "Text Field is empty";
      }
      return null;
    },
    keyboardType: keyboard,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
    ),
  );
}
