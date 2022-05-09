import 'package:firebase_database/firebase_database.dart';

class User {
  String? uid;
  String? firstName;
  String? lastName;
  String? initiales;
  String? civilite;
  String? email;
  String? phone;

  GetUser(DataSnapshot dataSnapshot) {
    uid = dataSnapshot.key;
    Map<dynamic, dynamic> map = (dataSnapshot.value as Map);
    firstName = map["firstname"];
    lastName = map['lastName'];
    civilite = map['civilite'];
    email = map['email'];
    phone = map['phone'];
  }

  Map toMap() {
    return {
      "firstname": firstName,
      "lastName": lastName,
      "uid": uid,
      "civilite": civilite,
      "email": email,
      "phone": phone
    };
  }
}
