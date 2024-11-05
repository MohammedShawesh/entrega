import 'package:bloc/bloc.dart';
import 'package:entrega/models/models.dart';
import 'package:entrega/screens/admin_screens/new_flight/cubit/new_flight_cubit.dart';
import 'package:flutter/material.dart';

part 'new_flight_card_state.dart';

class NewFlightCardCubit extends Cubit<NewFlightCardState> {
  NewFlightCardCubit() : super(NewFlightCardInitial());
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  String departureTime = '';
  final List<Time> departureTimes = [];
  final key = GlobalKey<FormState>();
  final price = TextEditingController(),
      seats = TextEditingController(),
      tripTitle = TextEditingController();

  String selectedDay = 'Sunday';

  removeTime(Time time) {
    departureTimes.remove(time);
    emit(NewFlightCardLoaded());
  }

  addTime() {
    if (departureTime.isNotEmpty) {
      var index = departureTimes.indexWhere((e) => e.day == selectedDay);
      if (departureTimes.isEmpty || index == -1) {
        departureTimes.add(
          Time(
            day: selectedDay,
            departureTime: [departureTime],
          ),
        );
      } else {
        departureTimes[index].departureTime.add(departureTime);
      }
      departureTime = '';
    }
    emit(NewFlightCardLoaded());
  }

  Future<void> selectTime(BuildContext context) async {
    emit(NewFlightCardLoading());
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      departureTime = time.format(context);
    }
    emit(NewFlightCardLoaded());
  }

  addDestination(NewFlightCubit controller) {
    if (!key.currentState!.validate()) return;
    controller.addDestination(
      TravelLocation(
        title: tripTitle.text,
        price: double.parse(price.text),
        times: departureTimes.map((e) => e).toList(),
        seats: int.parse(seats.text),
      ),
    );
    clear();
  }

  void selectDay(String? day) {
    if (day != null) {
      selectedDay = day;
    }
    emit(NewFlightCardLoaded());
  }

  void clear() {
    tripTitle.clear();
    price.clear();
    departureTimes.clear();
    departureTime = '';
    emit(NewFlightCardLoaded());
  }
}
