import 'dart:async';

import 'package:entrega/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const Loginscreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Center(
            child: Lottie.asset(
              'assets/lottie/Animation - 1725472849453.json', // replace with your animation file path
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "Entrega",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 226, 142, 103),
            ),
          )
        ],
      ),
    );
  }
}    // Scaffold(
    //   backgroundColor: Color.fromARGB(255, 222, 244, 248),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 200,
    //         ),
    //         Image.asset("images/car.png"),
    //         Text(
    //           "Entrega",
    //           style: TextStyle(
    //             fontSize: 30,
    //             fontWeight: FontWeight.bold,
    //             color: Color.fromARGB(255, 71, 100, 114),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  
