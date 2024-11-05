import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/authentication.dart';
import 'package:entrega/screens/home_screen.dart';
import 'package:entrega/servers/alerts.dart';
import 'package:entrega/servers/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Driverscreen extends StatefulWidget {
  const Driverscreen({super.key});

  @override
  State<Driverscreen> createState() => _DriverscreenState();
}

class _DriverscreenState extends State<Driverscreen> {
  Future<void> checkDriverExistenceAndPrintMessage(String driverId) async {
    bool isDriverExist = false;

    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('users')
        .where('driverId', isEqualTo: driverId)
        .get();

    if (result.docs.isNotEmpty) {
      isDriverExist = true;
    }

    if (isDriverExist) {
      print('Driver data with ID $driverId exists.');
    } else {
      print('Driver data with ID $driverId does not exist.');
    }
  }

  MapScreen mapScreen = const MapScreen();
  LatLng? driverLocation;

  void updateDriverLocation(LatLng newLocation) {
    setState(() {
      driverLocation = newLocation;
    });
  }

  @override
  initState() {
    if (Authentication.user == null) return;
    var user = Authentication.user!;
    name.text = user.name;
    phonenumSingup.text = user.phoneNumber.toString();
    dln.text = user.dnl;
    personalproof.text = user.idNumber.toString();
    gender = user.gender.isEmpty ? null : user.gender;
    gendercontroller.text = user.gender;
    subscription = user.subscriptionType.isEmpty ? null : user.subscriptionType;
    typeOfTrasportation =
        user.typeOfTrasportation.isEmpty ? null : user.typeOfTrasportation;
    super.initState();
  }

  Future<void> saveDriverLocation(String driverId) async {
    PermissionStatus status = await Permission.location.request();

    if (!status.isGranted) {
      print('Permission denied');
      return;
    }

    // تحديد موقع السائق
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    // الوصول إلى كولكشن "users"
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // حفظ موقع السائق وبياناته في Firestore
      await users.doc(driverId).set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        "name": name.text,
        "phone": phonenumSingup.text,
        "email": emaill.text,
        "Dnl": dln.text,
        "personal": personalproof.text,
        "gender": gender,
        "Type of trasportation": typeOfTrasportation,
        "isActive": false,
        "sup": subscription,
        "type": "driver",
        // يمكنك إضافة معلومات إضافية عن السائق هنا
      });

      // تحديث موقع السائق وعرض العلامة على الخريطة
      updateDriverLocation(LatLng(position.latitude, position.longitude));

      print('تم حفظ موقع السائق بنجاح');
    } catch (e) {
      print('حدث خطأ أثناء حفظ موقع السائق: $e');
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController phonenumSingup = TextEditingController();
  TextEditingController emaill = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController dln = TextEditingController();
  TextEditingController personalproof = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();
  final TextEditingController _dateController = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();

  String? valueChoose;
  String? valueChoose1;
  String? valueChoose2;
  DateTime dateTime = DateTime(2024, 2, 1);
  String? gender;
  String? subscription;
  String? typeOfTrasportation;

  // double _latitude = 0;
  // double _longitude = 0;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          "name": name.text,
          "phone": phonenumSingup.text,
          "email": emaill.text,
          "Dnl": dln.text,
          "personal": personalproof.text,
          "gender": gender,
          "Type of trasportation": typeOfTrasportation,
          "sup": subscription,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

// Call the function with the driver ID to check and print the existence

  List listItem = [
    "Female",
    "male",
  ];
  List listItem2 = ["motorcycle", "car", "bus"];

  List listItem1 = [
    "monthly",
    "weekly",
  ];

  String? username;
  String? phonenum;
  String? email;
  String? drivihgN;
  String? personalP;
  bool isGenderSelected = false;
  bool isVehicleTypeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Form(
            key: formstate,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  " Recording driver data ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 226, 142, 103),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: name,
                  initialValue:
                      null, // Set either initialValue or controller to null
                  onSaved: (newValue) {
                    username = newValue;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 20) {
                      return "The name cannot be more than 20 characters ";
                    }
                    if (value.length < 5) {
                      return "The name cannot be less than 5 characters ";
                    }
                    return null;
                  },
                  readOnly: Authentication.user != null,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "User name",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phonenumSingup,
                  initialValue:
                      null, // Set either initialValue or controller to null
                  keyboardType: TextInputType.phone,
                  readOnly: Authentication.user != null,
                  onSaved: (newValue) {
                    phonenum = newValue;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 10) {
                      return "The Phone Number cannot be more than 10 characters ";
                    }
                    if (value.length < 9) {
                      return "The Phone Number cannot be less than 9 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Phone Number",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: dln,
                  initialValue:
                      null, // Set either initialValue or controller to null
                  keyboardType: TextInputType.phone,
                  readOnly: Authentication.user != null,
                  onSaved: (newValue) {
                    drivihgN = newValue;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 20) {
                      return "The name cannot be more than 20 characters ";
                    }
                    if (value.length < 5) {
                      return "The name cannot be less than 5 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: " Driving license number ",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: personalproof,
                  initialValue:
                      null, // Set either initialValue or controller to null
                  keyboardType: TextInputType.phone,
                  readOnly: Authentication.user != null,
                  onSaved: (newValue) {
                    personalP = newValue;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Text Field is empty";
                    }
                    if (value.length > 20) {
                      return "The name cannot be more than 20 characters ";
                    }
                    if (value.length < 5) {
                      return "The name cannot be less than 5 characters ";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: (" Personal proof"),
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 57,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: DropdownButton(
                    onTap: () {},
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: const Text("  Gender"),
                    value: gender,
                    onChanged: (newValue) {
                      if (Authentication.user != null) return;
                      setState(() {
                        gender = newValue as String;
                        isGenderSelected = true;
                      });
                    },
                    items: listItem.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 57,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(3)),
                  child: DropdownButton(
                    onTap: () {},
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: const Text("  Type of trasportation"),
                    value: typeOfTrasportation,
                    onChanged: (newValue) {
                      if (Authentication.user != null) return;
                      setState(() {
                        typeOfTrasportation = newValue as String;
                        isVehicleTypeSelected = true;
                      });
                    },
                    items: listItem2.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(3)),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: const Text("  subscription service"),
                    value: subscription,
                    onChanged: (newValue) {
                      if (Authentication.user != null) return;
                      setState(() {
                        subscription = newValue as String;
                      });
                    },
                    items: listItem1.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 215, 246, 255)),
                  onPressed: () {
                    if (Authentication.user != null) {
                      Alerts.errorSnackBar(
                          "You're already signed up as a driver");
                      return;
                    }
                    if (!isGenderSelected) {
                      Alerts.errorSnackBar('Please select your gender');
                      return;
                    }
                    if (!isVehicleTypeSelected) {
                      Alerts.errorSnackBar('Please select your vehicle type');
                      return;
                    }
                    String driverId = FirebaseAuth.instance.currentUser!.uid;
                    if (formstate.currentState!.validate()) {
                      formstate.currentState!.save();
                      saveDriverLocation(driverId);
                      checkDriverExistenceAndPrintMessage(driverId);
                      AwesomeDialog(
                        buttonsTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 226, 142, 103)),
                        btnOkColor: const Color.fromARGB(255, 222, 244, 248),
                        context: context,
                        dialogType: DialogType.noHeader,
                        animType: AnimType.scale,
                        title: 'نحن سعداء لانضمامك إلى فريق عمل Entrega ',
                        desc:
                            ' في انتظار تفاصيل تسجيلك لكي نقوم بالموافقة عليك. سوف يتم إرسال رسالة مباشرة إلى بريدك الإلكتروني لإعلامك بالتفاصيل والبدء في العمل. نتطلع إلى العمل معك وتحقيق نجاح مشترك',
                        // btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );

                          // openRegistrationScreenIfDataNotSaved(
                          //   'driver123',
                          // ); // print(username);
                        },
                      ).show();
                    } else {
                      print("not valid");
                    }
                  },
                  child: const Text(
                    " Send request  ",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 226, 142, 103),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<void> _selectData() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              // primaryColor: Color.fromARGB(255, 245, 5, 5),
              // hintColor: Color.fromARGB(255, 20, 30, 39),
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 71, 100, 114),
                onPrimary: Color.fromARGB(
                    255, 255, 255, 255), // لون النص على العنصر الأساسي
                surface: Colors.white, // لون العنصر السطحي
                onSurface:
                    Color.fromARGB(255, 0, 0, 0), // لون النص على العنصر السطحي
              ),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
