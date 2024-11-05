import 'package:entrega/screens/admin_screens/admin_manage_driver.dart';
import 'package:entrega/screens/admin_screens/admin_manage_flights.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Admin services",
          style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              height: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 215, 246, 255)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminManageFlights(),
                    ),
                  );
                },
                child: const Text(
                  " Manage Flights ",
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
                    backgroundColor: const Color.fromARGB(255, 215, 246, 255)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminManageDriver(),
                    ),
                  );
                },
                child: const Text(
                  "   Manage drivers   ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 226, 142, 103),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
