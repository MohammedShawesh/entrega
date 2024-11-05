import 'package:entrega/authentication.dart';
import 'package:entrega/screens/contact_us/contact_us.dart';
import 'package:entrega/screens/login_screen.dart';
import 'package:entrega/screens/profile.dart';
import 'package:entrega/servers/test_screen.dart';
import 'package:entrega/servers/weekly_servers.dart';
import 'package:entrega/screens/home_screen.dart';
import 'package:entrega/servers/map_screen.dart';
import 'package:entrega/servers/monthly_screen.dart';
import 'package:entrega/servers/trips_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Passengerscreen extends StatefulWidget {
  const Passengerscreen({super.key});

  @override
  State<Passengerscreen> createState() => _PassengerscreenState();
}

bool isDarkModeEnabled = false;

class _PassengerscreenState extends State<Passengerscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Passenger services",
          style: TextStyle(
            color: Color.fromARGB(255, 226, 142, 103),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/lottie/Animation - 1725472849453.json', // replace with your animation file path
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 215, 246, 255)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    " Request delivery service ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 226, 142, 103),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 215, 246, 255)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "   Monthly subscription ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 226, 142, 103),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 215, 246, 255)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeekServers(),
                      ),
                    );
                  },
                  child: const Text(
                    "  Weekly subscription   ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 226, 142, 103),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: 350,
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 215, 246, 255)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TripsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "   Booking local flights  ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 226, 142, 103),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          padding: const EdgeInsets.all(1),
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    height: 290,
                    child: Image.asset(
                      "images/hader.jpg",
                      color: const Color.fromARGB(255, 173, 212, 223),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: const Text(
                  "Home",
                  style: TextStyle(color: Color.fromARGB(255, 226, 142, 103)),
                ),
                leading: const Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 173, 212, 223),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Color.fromARGB(255, 226, 142, 103)),
                ),
                leading: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 173, 212, 223),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const ProfileView(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  "Order",
                  style: TextStyle(color: Color.fromARGB(255, 226, 142, 103)),
                ),
                leading: const Icon(
                  Icons.check_box,
                  color: Color.fromARGB(255, 173, 212, 223),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const MapScreen(),
                    ),
                  );
                },
              ),
              if (Authentication.user != null &&
                  Authentication.user?.userType == 'driver')
                ListTile(
                  title: const Text(
                    "Driver availablity",
                    style: TextStyle(color: Color.fromARGB(255, 226, 142, 103)),
                  ),
                  leading: const Icon(
                    Icons.car_repair,
                    color: Color.fromARGB(255, 173, 212, 223),
                  ),
                  trailing: Switch(
                    value: Authentication.user!.availability,
                    onChanged: (newValue) async {
                      Authentication.user = Authentication.user!.copyWith(
                        availability: !Authentication.user!.availability,
                      );
                      await Authentication.updateDriver(Authentication.user!);
                      setState(() {});
                    },
                  ),
                  onTap: () {},
                ),
              ListTile(
                title: const Text(
                  "Contact us",
                  style: TextStyle(color: Color.fromARGB(255, 226, 142, 103)),
                ),
                leading: const Icon(
                  Icons.phone_android_outlined,
                  color: Color.fromARGB(255, 173, 212, 223),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const ContactUsView(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  "SignOut ",
                  style: TextStyle(color: Color.fromARGB(255, 226, 142, 103)),
                ),
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 173, 212, 223),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Loginscreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
