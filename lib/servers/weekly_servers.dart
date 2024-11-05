import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WeekServers extends StatefulWidget {
  const WeekServers({super.key});

  @override
  State<WeekServers> createState() => _WeekServersState();
}

class _WeekServersState extends State<WeekServers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weekly subscription drivers List',
          style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else {
            List<String> usersData = snapshot.data!.docs.map((doc) {
              if (doc['sup'] == 'weekly') {
                return 'Driver Name: ${doc['name']},                                     Phone Number: ${doc['phone']},                              Type gender: ${doc['gender']},                              Vehicle type: ${doc['Type of trasportation']},                                       Weekly Supervisor                             -------------------------------------------------------------------';
              } else {
                print(
                    'No weekly supervisor assigned for user: ${doc['name']}'); // Print message to terminal
                return ''; // Return an empty string
              }
            }).toList();
            return ListView.builder(
              itemCount: usersData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(usersData[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
