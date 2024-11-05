import 'dart:convert';

class Time {
  final String day;
  final List<String> departureTime;

  Time({
    required this.day,
    required this.departureTime,
  });

  Time copyWith({
    String? day,
    List<String>? departureTime,
  }) {
    return Time(
      day: day ?? this.day,
      departureTime: departureTime ?? this.departureTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'departureTime': departureTime,
    };
  }

  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      day: map['day'] as String,
      departureTime: (map['departureTime'] as List<dynamic>)
          .map((x) => x.toString())
          .toList(),
    );
  }
  String toJson() => json.encode(toMap());

  factory Time.fromJson(String source) =>
      Time.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Time(day: $day, departureTime: $departureTime)';
}
