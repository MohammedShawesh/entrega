import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/details/details_screen.dart';
import 'package:entrega/models/models.dart';
import 'package:entrega/screens/home_screen.dart';
import 'package:entrega/servers/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Booking local flights ",
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('flights')
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("No Flights Found"),
                      );
                    }
                    final documents = snapshot.data!.docs;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: documents.map((e) {
                        final des = Reservation.fromMap(e.id, e.data());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    width: 170,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    des.image,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      des.name,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color:
                                            Color.fromARGB(255, 226, 142, 103),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 140,
                                        ),
                                        IconButton(
                                          color: const Color.fromARGB(
                                              255, 173, 212, 223),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreen(
                                                  reservation: des,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Transform.flip(
                                            flipX: true,
                                            child: const Icon(
                                              Icons.arrow_back_ios,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 217, 233, 236),
        child: Container(
          padding: const EdgeInsets.all(1),
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    height: 290,
                    child: Image.asset("images/hader.jpg"),
                  ),
                ],
              ),
              ListTile(
                title: const Text("Home"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const HomeScreen()));
                },
              ),
              ListTile(
                title: const Text("Order"),
                leading: const Icon(Icons.check_box),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const MapScreen()));
                },
              ),
              ListTile(
                title: const Text("Contact us"),
                leading: const Icon(Icons.phone_android_outlined),
                onTap: () {},
              ),
              ListTile(
                title: const Text("SignOut "),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    exit(0);
                  }
                },
              ),
              ListTile(
                title: const Text("Dark Theme"),
                leading: const Icon(Icons.dark_mode),
                trailing: Switch(
                  value: isDarkModeEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      isDarkModeEnabled = newValue;
                    });
                  },
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
