import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  //AUTH
  final auth = FirebaseAuth.instance;

  Future<User?> handleSignIn(String email, String password) async {
    final User? user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<User?> create(String email, String password, String gender,
      String firstName, String lastName, String phone) async {
    final create = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User? user = create.user;
    var users = FirebaseFirestore.instance.collection('Users');
    final currentUser = await FirebaseAuth.instance.currentUser!;
    final uid = currentUser.uid.toString();
    users.add({
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "phone": phone,
      "email": email
    });
    return user;
  }

  Future<User?> changePassword(String password) async {
    User user = await FirebaseAuth.instance.currentUser!;

    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
