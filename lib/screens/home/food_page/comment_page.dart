import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaffe/models/comment.dart';
import 'package:kaffe/models/food.dart';
import 'package:kaffe/utils/constants.dart';

import '../../../models/data.dart' as data;

final _firestore = FirebaseFirestore.instance;
User loggedIn;

class CommentScreen extends StatefulWidget {
  static const String route = '/comment_screen';
  final Food food;
  CommentScreen({Key key, this.food}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState(food: food);
}

class _CommentScreenState extends State<CommentScreen> {
  _CommentScreenState({@required Food food}) {
    FirebaseAuth.instance
        .signInAnonymously()
        .then((UserCredential userCredential) {
      data.getFood(food.id).then((Food food) {
        _currentCommentSubscription?.cancel();
        setState(() {
          if (userCredential.user.displayName == null ||
              userCredential.user.displayName.isEmpty) {
            _userName = 'Anonymous';
          } else {
            _userName = userCredential.user.displayName;
          }
          _food = food;
          _userId = userCredential.user.uid;

          // Initialize the reviews snapshot...
          _currentCommentSubscription = widget.food.reference
              .collection('comments')
              .orderBy('timestamp', descending: true)
              .snapshots()
              .listen((QuerySnapshot commentSnap) {
            setState(() {
              _isLoading = false;
              _comment = commentSnap.docs.map((DocumentSnapshot doc) {
                return Comment.fromSnapshot(doc);
              }).toList();
            });
          });
        });
      });
    });
  }

  StreamSubscription<QuerySnapshot> _currentCommentSubscription;
  Food _food;

  String _userId;
  String _userName;
  bool _isLoading = false;
  List<Comment> _comment;

  String messageText;
  final messageTextController = TextEditingController();

  @override
  void dispose() {
    _currentCommentSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Comment',
            style: Theme.of(context).textTheme.headline6,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _comment == null
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView(
                        children: _comment
                            .map((Comment comment) => CommentBubble(
                                  sender: comment.userName,
                                  text: comment.text,
                                  isMe: true,
                                ))
                            .toList())),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Comment comment = Comment.fromUserInput(
                        text: messageTextController.text,
                        userId: _userId,
                        userName: _userName,
                      );
                      data.addComment(foodId: _food.id, comment: comment);
                      messageTextController.clear();
                    },
                    child: Text(
                      'Post',
                      style: Theme.of(context).textTheme.button.copyWith(
                          fontWeight: FontWeight.normal,
                          color: kSecondaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          }
          final messages = snapshot.data.docs.reversed;
          List<CommentBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final currentUser = loggedIn.email;

            final messageBubble = CommentBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        });
  }
}

class CommentBubble extends StatelessWidget {
  CommentBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(
          Icons.person,
          color: kBlackColor,
        ),
        backgroundColor: kPrimaryColor,
      ),
      subtitle: Text(text, style: Theme.of(context).textTheme.bodyText1),
      title: Text(
        "$sender ${isMe ? "(You)" : ""}",
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
