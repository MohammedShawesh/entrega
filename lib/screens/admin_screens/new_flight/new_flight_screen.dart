import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/models/models.dart';
import 'package:entrega/screens/admin_screens/new_flight/components/new_destination_card.dart';
import 'package:entrega/screens/admin_screens/new_flight/cubit/new_flight_cubit.dart';
import 'package:entrega/screens/admin_screens/widgets/button.dart';
import 'package:entrega/screens/admin_screens/widgets/input_field.dart';
import 'package:entrega/servers/alerts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewFlightScreen extends StatefulWidget {
  const NewFlightScreen({super.key});

  @override
  State<NewFlightScreen> createState() => _NewFlightScreenState();
}

class _NewFlightScreenState extends State<NewFlightScreen> {
  XFile? imageFile;
  final key = GlobalKey<FormState>();
  final image = TextEditingController(), name = TextEditingController();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewFlightCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            "Add new flight",
            style: TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('From'),
                  const SizedBox(height: 6),
                  inputField(name, 'From'),
                  const SizedBox(height: 12),
                  const Text('Image'),
                  const SizedBox(height: 6),
                  if (imageFile != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(imageFile!.path),
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        IconButton.filled(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          tooltip: 'Update Image',
                          onPressed: () async {
                            imageFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (imageFile != null) {
                              setState(() {});
                            }
                          },
                          icon: const Icon(
                            Icons.upload_file,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                      ],
                    )
                  else
                    InkWell(
                      onTap: () async {
                        imageFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (imageFile != null) {
                          setState(() {});
                        }
                      },
                      radius: 8,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        width: double.infinity,
                        child: const Center(
                          child: Text('Select Image'),
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        const Text('Destinations'),
                        BlocBuilder<NewFlightCubit, NewFlightState>(
                          builder: (context, state) {
                            final controller = context.read<NewFlightCubit>();
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.destinations.length,
                              itemBuilder: (ctx, index) {
                                final destination =
                                    controller.destinations[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "To ${destination.title} : ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 226, 142, 103),
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          Container(
                                            margin: const EdgeInsetsDirectional
                                                .only(end: 20),
                                            child: Text(
                                              '${destination.price} LYD',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 71, 100, 114),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: destination.times.length,
                                      itemBuilder: (ctx, index) {
                                        final time = destination.times[index];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Day: ${time.day}'),
                                            Text(
                                                'Departure Time: ${time.departureTime.join(', ')}'),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  const NewDestinationCard(),
                  const SizedBox(height: 20),
                  BlocBuilder<NewFlightCubit, NewFlightState>(
                    builder: (context, state) {
                      final controller = context.read<NewFlightCubit>();
                      return button("Add Flight", () async {
                        if (imageFile == null) {
                          Alerts.errorSnackBar('Please upload an image');
                          return;
                        }
                        if (context
                            .read<NewFlightCubit>()
                            .destinations
                            .isEmpty) {
                          Alerts.errorSnackBar(
                              'Please add at least one destination');
                          return;
                        }
                        if (!key.currentState!.validate()) {
                          return;
                        }
                        String fileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Reference storageReference = FirebaseStorage.instance
                            .ref()
                            .child('images/${imageFile!.name}$fileName');
                        UploadTask uploadTask =
                            storageReference.putFile(File(imageFile!.path));
                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() {
                          print('File uploaded');
                        });
                        String imageUrl =
                            await taskSnapshot.ref.getDownloadURL();
                        final flight = Reservation(
                          id: '',
                          name: name.text,
                          image: imageUrl,
                          destinations: controller.destinations,
                        );
                        await FirebaseFirestore.instance
                            .collection('flights')
                            .add(flight.toMap())
                            .then((v) {
                          Navigator.pop(context);
                        }).catchError((e) {
                          print(e);
                        });
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
