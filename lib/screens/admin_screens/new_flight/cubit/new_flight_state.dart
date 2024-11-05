part of 'new_flight_cubit.dart';

@immutable
sealed class NewFlightState {}

final class NewFlightInitial extends NewFlightState {}

final class NewFlightLoading extends NewFlightState {}

final class NewFlightSuccess extends NewFlightState {}
