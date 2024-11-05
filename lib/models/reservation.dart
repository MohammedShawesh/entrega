import 'package:flutter/foundation.dart';

import 'package:entrega/models/travel_location.dart';

class Reservation {
  final String id;
  final String name;
  final String image;
  final List<TravelLocation> destinations;

  Reservation({
    required this.id,
    required this.name,
    required this.image,
    required this.destinations,
  });

  Reservation copyWith({
    String? id,
    String? name,
    String? image,
    List<TravelLocation>? destinations,
  }) {
    return Reservation(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      destinations: destinations ?? this.destinations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': id,
      'name': name,
      'image': image,
      'destinations': destinations.map((x) => x.toMap()).toList(),
    };
  }

  factory Reservation.fromMap(String uid, Map<String, dynamic> map) {
    return Reservation(
      id: uid,
      name: map['name'] as String,
      image: map['image'] as String,
      destinations: (map['destinations'] as List<dynamic>)
          .map<TravelLocation>(
            (x) => TravelLocation.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  String toString() =>
      'Reservation(name: $name, image: $image, destinations: $destinations)';
}
