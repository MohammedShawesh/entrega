import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/models/models.dart';
import 'package:entrega/screens/home_screen.dart';
import 'package:entrega/servers/alerts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({
    required this.reservation,
    super.key,
  });
  final Reservation reservation;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final formstate = GlobalKey<FormState>();
  bool isDaySelected = false;
  bool isTimeSelected = false;
  bool isDestinationSelected = false;
  final int maxvalue = 25;
  final int minvalue = 0;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  CollectionReference reservationsCollection =
      FirebaseFirestore.instance.collection('reservations');
  CollectionReference flightCollection =
      FirebaseFirestore.instance.collection('flights');

  int seats = 0;
  String? valueCity;
  String? valueDay;
  String? valueTaime;
  TravelLocation? selectLocation;
  Time? selectedTime;
  Future<void> addReservation() {
    if (seats == 0) {
      Alerts.errorSnackBar('Please select the number of seats');
      return Future.value();
    }
    // Call the user's CollectionReference to add a new user
    return reservationsCollection.add({
      'flight_id': widget.reservation.id,
      "from": widget.reservation.name,
      "name": name.text,
      "phone": phoneNumber.text,
      "destination": valueCity,
      "Day": valueDay,
      "Time": valueTaime,
      "booked_time": DateTime.now(),
    }).then((value) {
      var reservation = widget.reservation;
      reservation
              .destinations[reservation.destinations.indexOf(selectLocation!)] =
          selectLocation!.copyWith(booked: selectLocation!.booked + seats);
      flightCollection.doc(widget.reservation.id).update(reservation.toMap());
    }).catchError((error) => print("Failed to add reservationTriboli: $error"));
  }

  void _increment() {
    if (selectLocation == null) {
      Alerts.errorSnackBar('Please select the destination');
      return;
    }
    if (seats < maxvalue && seats < selectLocation!.seatsLeft) {
      setState(() {
        seats++;
      });
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'There is only ${selectLocation!.seatsLeft} seats left',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }

  void _decrement() {
    if (seats > minvalue) {
      setState(() {
        seats--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Reservation ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color.fromARGB(255, 226, 142, 103),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formstate,
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/lottie/Animation - 1725486505617.json', // replace with your animation file path
                      width: 250,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.reservation.name,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 226, 142, 103),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: name,
                    initialValue:
                        null, // Set either initialValue or controller to null
                    // onSaved: (newValue) {
                    //   username = newValue;
                    // },
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
                        hintText: "User name",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneNumber,
                    initialValue:
                        null, // Set either initialValue or controller to null
                    // onSaved: (newValue) {
                    //   username = newValue;
                    // },
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      if (value.length != 10) {
                        return "The phone number must be 10 digits";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Phone number",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
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
                      hint: const Text("  To City"),
                      value: selectLocation,
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue != null) {
                            selectLocation = newValue;
                            valueCity = selectLocation!.title;
                            isDestinationSelected = true;
                          }
                        });
                      },
                      items: widget.reservation.destinations.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem.title,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        " Number of Individuals",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 71, 153, 190)),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 215, 246, 255)),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 20,
                          ),
                          onPressed: _increment,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "$seats",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 215, 246, 255)),
                        child: IconButton(
                          icon: const Icon(Icons.remove, size: 20),
                          onPressed: _decrement,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                      hint: const Text("   Day "),
                      value: selectedTime,
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue != null) {
                            selectedTime = newValue;
                            valueDay = newValue.day;
                            isDaySelected = true;
                          }
                        });
                      },
                      items: (selectLocation?.times ?? []).map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem.day,
                          ),
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
                      hint: const Text("  Time "),
                      value: valueTaime,
                      onChanged: (newValue) {
                        setState(() {
                          valueTaime = newValue as String;
                          isTimeSelected = true;
                        });
                      },
                      items:
                          (selectedTime?.departureTime ?? []).map((valueItem) {
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
                    onPressed: isDaySelected &&
                            isTimeSelected &&
                            isDestinationSelected
                        ? () {
                            if (formstate.currentState!.validate()) {
                              addReservation();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                              AwesomeDialog(
                                buttonsTextStyle: const TextStyle(
                                    color: Color.fromARGB(255, 226, 142, 103)),
                                btnOkColor:
                                    const Color.fromARGB(255, 222, 244, 248),
                                context: context,
                                dialogType: DialogType.noHeader,
                                animType: AnimType.scale,
                                title: 'Entrega يُسرّ فريق  ',
                                desc:
                                    ' أن يكون قد حجز مقعدًا لك في رحلتنا نتمنى لك رحلة سعيدة وممتعة يُرجى أن تحضر إلى مكان الانطلاق قبل موعد الرحلة بنصف ساعة لضمان الانطلاق في الوقت المحدد. ',
                                // btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                            } else {
                              print("not valid");
                            }
                          }
                        : null,
                    child: const Text(
                      " reservation",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 226, 142, 103),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
