import 'dart:convert';

import 'time.dart';

class TravelLocation {
  final String title;
  final double price;
  final List<Time> times;
  final int seats;
  final int booked;

  int get seatsLeft => seats - booked;

  TravelLocation({
    required this.title,
    required this.price,
    required this.times,
    required this.seats,
    this.booked = 0,
  });

  TravelLocation copyWith({
    String? title,
    double? price,
    List<Time>? times,
    int? seats,
    int? booked,
  }) {
    return TravelLocation(
      title: title ?? this.title,
      price: price ?? this.price,
      times: times ?? this.times,
      seats: seats ?? this.seats,
      booked: booked ?? this.booked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'times': times.map((x) => x.toMap()).toList(),
      'seats': seats,
      'booked': booked,
    };
  }

  factory TravelLocation.fromMap(Map<String, dynamic> map) {
    return TravelLocation(
      title: map['title'] as String,
      price: double.parse(map['price'].toString()),
      times: (map['times'] as List<dynamic>)
          .map<Time>(
            (x) => Time.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
      seats: map['seats'] as int? ?? 0,
      booked: map['booked'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelLocation.fromJson(String source) =>
      TravelLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TravelLocation(title: $title, price: $price, times: $times, seats: $seats)';
}
