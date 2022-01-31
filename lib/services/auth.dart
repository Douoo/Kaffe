import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:kaffe/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // create function to convert firebase user to custom user

  User _userFromFireBaseUser(auth.User user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //create a stream

  Stream<User> get user {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  // sign in anonymously
  Future signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      auth.User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
