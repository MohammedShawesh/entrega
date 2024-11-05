import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega/models/driver.dart';
import 'package:entrega/servers/alerts.dart';

class Authentication {
  static var userCollection = FirebaseFirestore.instance.collection('users');
  static Driver? user;
  static Future<void> getUserDetails(String uid) async {
    var response = await userCollection.doc(uid).get();
    if (response.exists && response.data() != null) {
      user = Driver.fromMap(uid, response.data()!);
    }
  }

  static Future<void> updateDriver(Driver driver) async {
    userCollection.doc(driver.uid).update(driver.toMap()).then((v) {
      Alerts.successSnackBar('Status Updated Successfully');
    }).catchError((e) {
      Alerts.errorSnackBar('Error Updating Status');
    });
  }
}
