import 'package:entrega/authentication.dart';
import 'package:entrega/screens/Driver_screen.dart';
import 'package:entrega/screens/admin_screens/admin_home_screen.dart';
import 'package:entrega/screens/passenger_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<void> saveDriverDataStatus(bool isDriverDataSaved) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isDriverDataSaved', isDriverDataSaved);
  // }

  // Future<bool> isDriverDataSaved() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isDriverDataSaved') ?? false;
  // }

  // void checkAndOpenRegistrationScreen() async {
  //   final isSaved = await isDriverDataSaved();
  //   if (!isSaved) {
  //     // السائق لم يقم بتسجيل بياناته بعد
  //     print('Driver data not saved. Opening registration screen.');
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const Driverscreen(),
  //       ),
  //     );
  //     saveDriverDataStatus(true);
  //     // اضف هنا الكود الخاص بفتح شاشة تسجيل البيانات
  //     // بعد إتمام عملية التسجيل، استخدم الدالة saveDriverDataStatus(true)
  //   } else {
  //     // السائق قد قام بتسجيل بياناته مسبقاً
  //     print('Driver data saved. Cannot open registration screen again.');
  //   }
  // }

  final List<Widget> _screens = const [
    Passengerscreen(),
    Driverscreen(),
    AdminHomeScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          navItem("Passenger", Icons.person, 0),
          navItem("Driver", Icons.drive_eta, 1),
          if (Authentication.user?.userType == 'admin')
            navItem("Admin", Icons.admin_panel_settings, 2),
        ],
      ),
      body: _screens[selectedIndex],
    );
  }

  setIndex(int index) {
    if (selectedIndex == index) return;
    setState(() {
      selectedIndex = index;
    });
  }

  Widget navItem(
    String title,
    IconData icon,
    int index,
  ) {
    return Expanded(
      child: IconButton(
        onPressed: () {
          setIndex(index);
        },
        icon: AnimatedScale(
          scale: selectedIndex == index ? 1.1 : 1,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selectedIndex == index
                    ? const Color.fromARGB(255, 226, 142, 103)
                    : null,
              ),
              Text(
                title,
                style: TextStyle(
                  color: selectedIndex == index
                      ? const Color.fromARGB(255, 226, 142, 103)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
