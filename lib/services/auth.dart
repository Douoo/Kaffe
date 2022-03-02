import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaffe/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth
      .instance; // HERE WE ARE USING THE SINGLETON PATTERN SINCE WE ARE ONLY USING ONE INSTANCE OF THE FIREBASE AUTH CLASS.

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

  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _auth.signInWithCredential(
          auth.GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFireBaseUser(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  //sign in with facebook

  Future<User> signInWithFacebook() async {
    try {
      final faceBookLogin = await FacebookAuth.instance.login();
      // final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential =
          auth.FacebookAuthProvider.credential(faceBookLogin.accessToken.token);
      final authResult =
          await _auth.signInWithCredential(facebookAuthCredential);
      return _userFromFireBaseUser(authResult.user);
    } on auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          print('This account exists with different credential');
          break;
        case 'invalid-credential':
          print('Unknown error occurred');
          break;
        case 'operation-not-allowed':
          print('This operation is not allowed');
          break;
        case 'user-disabled':
          print('The user you tried to log into is disabled');
          break;
        case 'user-not-found':
          print('The user you tried to log into was not found');
          break;
      }
    }
  }

  //sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final facebookSignIn = FacebookAuth.instance;
      await facebookSignIn.logOut();
      print('signed out');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
