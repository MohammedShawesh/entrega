import 'package:entrega/screens/admin_screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Contact Us",
          style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Contact Us Via:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            button(
              'Mail',
              () async {
                launchUrl(Uri.parse('mailto:ssss@gmail.com'));
              },
            ),
            const SizedBox(height: 8),
            button(
              'Phone Number',
              () async {
                launchUrl(Uri.parse('tel:+218910000000'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
