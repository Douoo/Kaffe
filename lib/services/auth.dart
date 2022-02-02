import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:kaffe/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // create function to convert firebase user to custom user

  User _userFromFireBaseUser(auth.User user) {
    return user != null
        ? User(uid: user.uid, name: user.displayName, email: user.email)
        : null;
  }

  String username() {
    return _auth.currentUser.displayName;
  }

  String email() {
    return _auth.currentUser.email;
  }

  //create a stream
  bool isAnonyomus() {
    return _auth.currentUser.isAnonymous;
  }

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

  Future registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser.updateProfile(displayName: username);
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
      print(
          "signed in successfully ${result.user.displayName} ${result.user.uid}");
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with Google

  // Future signInWithGoogle() async{
  //   try{
  //     final result = await _auth.si
  //   }
  // }

  //sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      print('signed out');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
