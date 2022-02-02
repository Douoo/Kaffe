import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import './values.dart';

// This is called "ratings" in the backend.
class Comment {
  final String id;
  final String userId;
  final String text;
  final String userName;
  final Timestamp timestamp;

  final DocumentReference reference;

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        text = snapshot.data()['text'],
        userName = snapshot.data()['userName'],
        userId = snapshot.data()['userId'],
        timestamp = snapshot.data()['timestamp'],
        reference = snapshot.reference;

  Comment.fromUserInput({this.text, this.userName, this.userId})
      : id = null,
        timestamp = null,
        reference = null;

  factory Comment.random({String userName, String userId}) {
    final random = Random().nextInt(4) + 1;
    final comment = getRandomReviewText(random);
    return Comment.fromUserInput(
        text: comment, userName: userName, userId: userId);
  }
}
