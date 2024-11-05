import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/models/models.dart';
import 'package:flutter/material.dart';

class AdminManageDriver extends StatelessWidget {
  const AdminManageDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Manage Drivers",
          style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                Driver driver = Driver.fromMap(snapshot.data!.docs[index].id,
                    snapshot.data!.docs[index].data());
                return driverCard(context, driver);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget driverCard(BuildContext context, Driver driver) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Driver Name: ${driver.name}'),
                  const SizedBox(height: 4),
                  if (driver.email.isNotEmpty) Text('Email: ${driver.email}'),
                  const SizedBox(height: 4),
                  Text('Gender: ${driver.gender}'),
                  const SizedBox(height: 4),
                  Text('Phone: ${driver.phoneNumber}'),
                  const SizedBox(height: 4),
                  Text('Type of transport: ${driver.typeOfTrasportation}'),
                  const SizedBox(height: 4),
                  Text("subscription: ${driver.subscriptionType}"),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Active'),
                    value: driver.isActive,
                    onChanged: (v) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(driver.uid)
                          .update(
                        {'isActive': v},
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
