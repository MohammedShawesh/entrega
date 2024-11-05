import 'package:entrega/authentication.dart';
import 'package:entrega/screens/Home_screen.dart';
import 'package:entrega/screens/forget_password_screen.dart';
import 'package:entrega/screens/sing_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emaill = TextEditingController();

  GlobalKey<FormState> formstateLogin = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Form(
            key: formstateLogin,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Lottie.asset(
                    'assets/lottie/Animation - 1725472849453.json', // replace with your animation file path
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Login In Entraga",
                  style: TextStyle(
                      color: Color.fromARGB(255, 226, 142, 103),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emaill,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 30) {
                      return "The name cannot be more than 20 characters ";
                    }
                    if (value.length < 13) {
                      return "The name cannot be less than 5 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Email",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 8) {
                      return "The password cannot be more than 8 characters ";
                    }
                    if (value.length < 8) {
                      return "The password cannot be less than 8 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Passwerd",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        " Forget password ?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 226, 142, 103),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 215, 246, 255),
                  ),
                  onPressed: () async {
                    if (formstateLogin.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emaill.text,
                          password: passwordController.text,
                        );
                        await Authentication.getUserDetails(
                          FirebaseAuth.instance.currentUser!.uid,
                        );
                        if (Authentication.user?.isActive == false) {
                          Fluttertoast.showToast(
                            msg: "Your account is not active",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        print('FirebaseAuthException: ${e.message}');
                        Fluttertoast.showToast(
                          msg: e.message ?? "An error occurred",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    }
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 226, 142, 103),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SingUp()));
                  },
                  child: const Text(
                    " Sign up",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 173, 212, 223),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
