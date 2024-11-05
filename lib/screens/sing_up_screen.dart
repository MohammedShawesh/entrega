import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/screens/Home_screen.dart';
import 'package:entrega/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});
// hhhjj
  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emaill = TextEditingController();
  TextEditingController phonenumSingup = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formstateSingup = GlobalKey();
  late String email;
  @override
  void initState() {
    super.initState();

    // Configure Firebase App Check
    // Enable billing for Firebase project
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Form(
            key: formstateSingup,
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
                  "Sing Up",
                  style: TextStyle(
                      color: Color.fromARGB(255, 226, 142, 103),
                      fontSize: 40,
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
                      return "The name cannot be less than 13 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Email",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                //
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phonenumSingup,
                  keyboardType: TextInputType.phone,
                  // onSaved: (newValue) {
                  //   phonenumSingup = newValue;
                  // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 10) {
                      return "The Phone Number cannot be more than 10 characters ";
                    }
                    if (value.length < 9) {
                      return "The Phone Number cannot be less than 9 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Phone Number",
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
                  // onSaved: (newValue) {
                  //   passwerdSingup = newValue;
                  // },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 8) {
                      return "The Phone Number cannot be more than 8 characters ";
                    }
                    if (value.length < 8) {
                      return "The Phone Number cannot be less than 8 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 8) {
                      return "The Phone Number cannot be more than 8 characters ";
                    }
                    if (value.length < 8) {
                      return "The Phone Number cannot be less than 8 characters ";
                    }
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return "The password does not match ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Confirm password",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),

                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 215, 246, 255)),
                  onPressed: () async {
                    if (formstateSingup.currentState!.validate()) {
                      // formstateSingup.currentState!.save();
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emaill.text,
                          password: passwordController.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Loginscreen(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    " Sing Up",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(255, 226, 142, 103),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 180,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
