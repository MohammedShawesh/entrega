import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:entrega/models/models.dart';
import 'package:entrega/screens/Driver_screen.dart';
import 'package:entrega/servers/alerts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? driverLocation;

  Driverscreen driverscreen = const Driverscreen();
  StreamSubscription<Position>? positionStream;
  initialStream() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.whileInUse) {}
    return await Geolocator.getCurrentPosition();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(32.021321, 20.152080),
    zoom: 11.0,
  );
  List<Marker> markers = [];
  @override
  void initState() {
    initialStream();
    initLocationStream();
    createDriverMarkers();
    super.initState();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  void showUsersDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Driver Data'),
          titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold),
          content: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data == null || snapshot.data!.data() == null) {
                  return const Text('User data not found');
                }
                Driver driver = Driver.fromMap(
                    userId, snapshot.data!.data() as Map<String, dynamic>);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text("Name"),
                      subtitle: Text(driver.name),
                    ),
                    ListTile(
                      title: const Text('Vehicle type'),
                      subtitle: Text(driver.typeOfTrasportation),
                    ),
                    ListTile(
                      title: const Text('Phone Number'),
                      subtitle: Text(driver.phoneNumber.toString()),
                    ),
                    ListTile(
                      title: const Text('Gender'),
                      subtitle: Text(driver.gender),
                    ),
                  ],
                );
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color.fromARGB(
                    255,
                    226,
                    142,
                    103,
                  ),
                ), // تغيير لون النص هنا
              ),
            ),
          ],
        );
      },
    );
  }

  initLocationStream() async {
    // Existing code to get current position
    PermissionStatus status = await Permission.location.request();
    if (!status.isGranted) {
      Alerts.errorSnackBar(
        'Location permission is required',
        action: SnackBarAction(
          label: 'Settings',
          onPressed: () async {
            await AppSettings.openAppSettings(type: AppSettingsType.location);
          },
        ),
      );
      return;
    } else {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        driverLocation = LatLng(position.latitude, position.longitude);
      });
    }
  }

  bool loading = true;

  createDriverMarkers() async {
    var collection = FirebaseFirestore.instance.collection('users');
    await collection.get().then(
      (users) {
        users.docs.forEach(
          (user) {
            var data = user.data();
            Driver driver = Driver.fromMap(user.id, data);
            if (driver.isActive && driver.availability) {
              markers.add(
                Marker(
                  markerId: MarkerId(user.id),
                  position: LatLng(
                    driver.latitude,
                    driver.longitude,
                  ),
                  onTap: () {
                    showUsersDialog(context, user.id);
                  },
                ),
              );
            }
          },
        );
      },
    );
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Google map",
        style: TextStyle(
            color: Color.fromARGB(255, 226, 142, 103),
            fontWeight: FontWeight.bold),
      )),
      body: GoogleMap(
        markers: loading ? {} : markers.toSet(),
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
