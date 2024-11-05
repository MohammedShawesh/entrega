import 'package:entrega/servers/map_screen.dart';
import 'package:flutter/material.dart';

class DetailsDriverScreen extends StatefulWidget {
  const DetailsDriverScreen({super.key});

  @override
  State<DetailsDriverScreen> createState() => _DetailsDriverScreenState();
}

class _DetailsDriverScreenState extends State<DetailsDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 244, 248),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 350,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                        width: 170,
                        height: 150,
                        fit: BoxFit.cover,
                        "images/personn.jpg"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    children: [
                      Text(
                        "shima",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 71, 100, 114),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "0926192179",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 71, 100, 114),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              height: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color.fromARGB(255, 71, 100, 114),
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
