import 'package:entrega/screens/admin_screens/widgets/input_field.dart';
import 'package:entrega/servers/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your email?',
          style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: const Text(
            'Please enter your email to verify your account.',
            style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          if (emailController.text.isEmpty) {
            Alerts.errorSnackBar('please enter your email');
            return;
          }
          FirebaseAuth.instance
              .sendPasswordResetEmail(email: emailController.text)
              .then((value) {
            Alerts.successSnackBar('A reset link has been sent to your email');
            Navigator.popUntil(context, (route) => route.isFirst);
          }).catchError((error) {
            Alerts.errorSnackBar('error sending message to your email');
          });
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50),
          backgroundColor: const Color.fromARGB(255, 215, 246, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103), fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
            child: Container(
          margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 32, vertical: 88),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroTexts(),
              const SizedBox(
                height: 70,
              ),
              const SizedBox(height: 6),
              inputField(emailController, "Email"),
              const SizedBox(
                height: 70,
              ),
              _buildNextButton(context),
            ],
          ),
        )),
      ),
    );
    return scaffold;
  }
}
