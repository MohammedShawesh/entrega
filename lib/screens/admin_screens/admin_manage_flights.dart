import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/models/models.dart';
import 'package:entrega/screens/admin_screens/new_flight/new_flight_screen.dart';
import 'package:entrega/screens/admin_screens/widgets/button.dart';
import 'package:flutter/material.dart';

class AdminManageFlights extends StatefulWidget {
  const AdminManageFlights({super.key});

  @override
  State<AdminManageFlights> createState() => _AdminManageFlightsState();
}

class _AdminManageFlightsState extends State<AdminManageFlights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Manage Flight",
          style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
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
                      child: Text("No data"),
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data!.docs.map((e) {
                      Reservation reservation =
                          Reservation.fromMap(e.id, e.data());
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                title: Text(reservation.name),
                                subtitle: Text(
                                    'Destinations: ${reservation.destinations.length}'),
                                trailing: IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('flights')
                                        .doc(e.id)
                                        .delete();
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 12),
              button('Add Flight', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewFlightScreen(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
