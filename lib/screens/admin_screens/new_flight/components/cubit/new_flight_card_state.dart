part of 'new_flight_card_cubit.dart';

@immutable
sealed class NewFlightCardState {}

final class NewFlightCardInitial extends NewFlightCardState {}

final class NewFlightCardLoading extends NewFlightCardState {}

final class NewFlightCardLoaded extends NewFlightCardState {}
