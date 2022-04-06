import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  //AUTH
  final auth = FirebaseAuth.instance;

  Future<User?> handleSignIn(String email, String password) async {
    final User? user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<User?> create(
      String email, String password, String firstName, String lastName) async {
    final create = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User? user = create.user;
    Map<String, String> map = {"firstName": firstName, "lastName": lastName};
    return user;
  }
}
