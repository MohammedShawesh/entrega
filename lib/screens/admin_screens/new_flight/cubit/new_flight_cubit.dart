import 'package:bloc/bloc.dart';
import 'package:entrega/models/travel_location.dart';
import 'package:meta/meta.dart';

part 'new_flight_state.dart';

class NewFlightCubit extends Cubit<NewFlightState> {
  NewFlightCubit() : super(NewFlightInitial());

  final List<TravelLocation> destinations = [];

  addDestination(TravelLocation destination) {
    emit(NewFlightLoading());
    destinations.add(destination);
    emit(NewFlightSuccess());
  }
}
