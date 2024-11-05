class Driver {
  final String uid;
  final String dnl;
  final String typeOfTrasportation;
  final String email;
  final String gender;
  final double longitude;
  final double latitude;
  final String name;
  final int idNumber;
  final int phoneNumber;
  final String subscriptionType;
  final String userType;
  final bool isActive;
  final bool availability;
  Driver({
    required this.uid,
    required this.dnl,
    required this.typeOfTrasportation,
    required this.email,
    required this.gender,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.idNumber,
    required this.phoneNumber,
    required this.subscriptionType,
    required this.userType,
    this.isActive = false,
    this.availability = true,
  });

  Driver copyWith({
    String? uid,
    String? dnl,
    String? typeOfTrasportation,
    String? email,
    String? gender,
    double? longitude,
    double? latitude,
    String? name,
    int? idNumber,
    int? phoneNumber,
    String? subscriptionType,
    String? userType,
    bool? isActive,
    bool? availability,
  }) {
    return Driver(
      uid: uid ?? this.uid,
      dnl: dnl ?? this.dnl,
      typeOfTrasportation: typeOfTrasportation ?? this.typeOfTrasportation,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      name: name ?? this.name,
      idNumber: idNumber ?? this.idNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      userType: userType ?? this.userType,
      isActive: isActive ?? this.isActive,
      availability: availability ?? this.availability,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'dnl': dnl.toString(),
      'typeOfTrasportation': typeOfTrasportation,
      'email': email,
      'gender': gender,
      'longitude': longitude,
      'latitude': latitude,
      'name': name,
      'idNumber': idNumber,
      'phoneNumber': phoneNumber,
      'subscriptionType': subscriptionType,
      'userType': userType,
      'isActive': isActive,
      'availability': availability,
    };
  }

  factory Driver.fromMap(String uid, Map<String, dynamic> map) {
    return Driver(
      uid: uid,
      dnl: map['Dnl'] ?? '',
      typeOfTrasportation: map['Type of trasportation'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      longitude: double.tryParse(map['longitude'].toString()) ?? 0.0,
      latitude: double.tryParse(map['latitude'].toString()) ?? 0.0,
      name: map['name'] ?? '',
      idNumber: int.tryParse(map['personal'].toString()) ?? 0,
      phoneNumber: int.tryParse(map['phone'].toString()) ?? 0,
      subscriptionType: map['sup'] ?? '',
      userType: map['type'] ?? 'driver',
      isActive: map['isActive'] ?? false,
      availability: map['availability'] ?? false,
    );
  }

  @override
  String toString() {
    return 'User(uid: $uid, dnl: $dnl, typeOfTrasportation: $typeOfTrasportation, email: $email, gender: $gender, longitude: $longitude, latitude: $latitude, name: $name, idNumber: $idNumber, phoneNumber: $phoneNumber, subscriptionType: $subscriptionType, userType: $userType, isActive: $isActive, availability: $availability)';
  }
}
