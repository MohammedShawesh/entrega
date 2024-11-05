import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 226, 142, 103),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Text('Email'),
            const SizedBox(height: 4),
            field(context, FirebaseAuth.instance.currentUser!.email!),
            const SizedBox(height: 8),
            const Text('Phone number'),
            const SizedBox(height: 4),
            field(
                context,
                FirebaseAuth.instance.currentUser!.phoneNumber ??
                    "User has no phone number"),
          ],
        ),
      ),
    );
  }

  Widget field(BuildContext context, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Text Field is empty";
        }
        if (value.length > 20) {
          return "The name cannot be more than 20 characters ";
        }
        if (value.length < 5) {
          return "The name cannot be less than 5 characters ";
        }
        return null;
      },
      readOnly: true,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
