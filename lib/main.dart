import 'package:entrega/authentication.dart';
import 'package:entrega/screens/home_screen.dart';
import 'package:entrega/screens/splash_screen.dart';
import 'package:entrega/servers/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    await Authentication.getUserDetails(FirebaseAuth.instance.currentUser!.uid);
  }
  runApp(
    const MyApp(),
  );
  // إعادة تشغيل المحاكي
  void restartEmulator() {
    // قم بتنفيذ العملية الخاصة بك هنا لإعادة تشغيل المحاكي
    // يمكنك محاولة إيقاف المحاكي ثم تشغيله مرة أخرى
  }

// استدعي الدالة لإعادة تشغيل المحاكي
  restartEmulator();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('===========================User is currently signed out!');
      } else {
        print('===========================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Alerts.rootScaffoldMessengerKey,
      home: FirebaseAuth.instance.currentUser == null
          ? const SplashScreen()
          : const HomeScreen(),
      // routes: {
      //   "confirem": (context) => confirmScreen(),
      //   "singup": (context) => Sing_up(),
      //   "login": (context) => loginscreen()
      // },    );
    );
  }
} 

// class MyApp extends StatelessWidget {
  
//   const MyApp({Key? key}) : super(key: key);

//   @override
  
//   Widget build(BuildContext context) {
//     return MaterialApp(
//     );
//   }
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//       theme: Provider.of<ThemeProvider>(context).themeData,
//     );
//   }
// }
