import 'package:entrega/models/models.dart';
import 'package:entrega/reservation/reservation_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    required this.reservation,
    super.key,
  });
  final Reservation reservation;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          " Trip Details",
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 226, 142, 103),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.reservation.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "  From ${widget.reservation.name} To:",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 226, 142, 103),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            ...widget.reservation.destinations.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "          To ${e.title} : ",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromARGB(255, 226, 142, 103),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 20),
                          child: Text(
                            '${e.price} LYD',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 71, 100, 114),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...e.times.map(
                    (time) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...time.departureTime.map((dep) {
                            return Row(
                              children: [
                                Text(
                                  "          ${time.day} :$dep ",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 71, 100, 114),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  width: 65,
                                ),
                              ],
                            );
                          }),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "          Total Seats: ${e.seats}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 226, 142, 103),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Seats left: ${e.seatsLeft}    ",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 226, 142, 103),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 215, 246, 255),
                  ),
                ],
              );
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 215, 246, 255)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationScreen(
                      reservation: widget.reservation,
                    ),
                  ),
                );
              },
              child: const Text(
                " reservation",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 226, 142, 103),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
