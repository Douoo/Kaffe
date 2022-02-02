import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String uid;
  final String name;
  final String email;

  User({this.uid, this.name, this.email});
}
