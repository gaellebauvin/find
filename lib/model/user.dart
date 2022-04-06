import 'package:firebase_database/firebase_database.dart';

class User {
  String? uid;
  String? firstName;
  String? lastName;
  String? imageUrl;
  String? initiales;

  GetUser(DataSnapshot dataSnapshot) {
    uid = dataSnapshot.key;
    Map<dynamic, dynamic> map = (dataSnapshot.value as Map);
    firstName = map["firstname"];
    lastName = map['lastName'];
    imageUrl = map['imageUrl'];
  }

  Map toMap() {
    return {
      "firstname": firstName,
      "lastName": lastName,
      "imageUrl": imageUrl,
      "uid": uid
    };
  }
}
