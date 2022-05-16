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

  Future<User?> create(String email, String password) async {
    final create = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User? user = create.user;
    return user;
  }

  Future<void> userSetup(String gender, String firstName, String lastName,
      String phone, String email) async {
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
    return;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
