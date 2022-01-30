import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/list_empty.dart';
import 'package:kaffe/components/review.dart';
import 'package:kaffe/models/restaurant.dart';
import 'package:kaffe/models/review.dart';
import 'package:kaffe/models/star.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:sliver_fab/sliver_fab.dart';
import '../../models/data.dart' as data;
import 'restaurant_page/create_review.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantPage({Key key, this.restaurant}) : super(key: key);

  @override
  State<RestaurantPage> createState() =>
      _RestaurantPageState(restaurant: restaurant);
}

class _RestaurantPageState extends State<RestaurantPage> {
  _RestaurantPageState({@required Restaurant restaurant}) {
    FirebaseAuth.instance
        .signInAnonymously()
        .then((UserCredential userCredential) {
      data.getRestaurant(restaurant.id).then((Restaurant restaurant) {
        _currentReviewSubscription?.cancel();
        setState(() {
          if (userCredential.user.displayName == null ||
              userCredential.user.displayName.isEmpty) {
            _userName = 'Anonymous';
          } else {
            _userName = userCredential.user.displayName;
          }
          _restaurant = restaurant;
          _userId = userCredential.user.uid;

          // Initialize the reviews snapshot...
          _currentReviewSubscription = widget.restaurant.reference
              .collection('ratings')
              .orderBy('timestamp', descending: true)
              .snapshots()
              .listen((QuerySnapshot reviewSnap) {
            setState(() {
              _isLoading = false;
              _reviews = reviewSnap.docs.map((DocumentSnapshot doc) {
                return Review.fromSnapshot(doc);
              }).toList();
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _currentReviewSubscription?.cancel();
    super.dispose();
  }

  bool _isLoading = true;
  StreamSubscription<QuerySnapshot> _currentReviewSubscription;

  Restaurant _restaurant;
  String _userId;
  String _userName;
  List<Review> _reviews = <Review>[];

  void _onCreateReviewPressed(BuildContext context) async {
    final newReview = await showDialog<Review>(
      context: context,
      builder: (_) => ReviewCreateDialog(
        userId: _userId,
        userName: _userName,
      ),
    );
    if (newReview != null) {
      // Save the review
      return data.addReview(
        restaurantId: _restaurant.id,
        review: newReview,
      );
    }
  }

  void _onAddRandomReviewsPressed() async {
    // Await adding a random number of random reviews
    final numReviews = Random().nextInt(5) + 5;
    for (var i = 0; i < numReviews; i++) {
      await data.addReview(
        restaurantId: _restaurant.id,
        review: Review.random(
          userId: _userId,
          userName: _userName,
        ),
      );
    }
  }

  @override
  void initState() {
    _restaurant = widget.restaurant;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
          //I changed the layout to a sliverFAB because I thought it might block the reviews from being seen in the bottom
          builder: (context) => SliverFab(
                floatingWidget: FloatingActionButton(
                  tooltip: 'Add a review',
                  backgroundColor: Colors.amber,
                  child: const Icon(Icons.rate_review),
                  onPressed: () => _onCreateReviewPressed(context),
                ),
                floatingPosition: FloatingPosition(right: 16),
                expandedHeight: 160,
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: kWhiteColor,
                      ),
                    ),
                    expandedHeight: 160,
                    forceElevated: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      title: Wrap(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.restaurant.name,
                                  style: TextStyle(fontSize: 10
                                      // fontSize:
                                      //     Theme.of(context).textTheme.caption.fontSize,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 80,
                                  alignment: Alignment.bottomLeft,
                                  child: StarRating(
                                    rating: widget.restaurant.avgRating,
                                    color: kSecondaryColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 6),
                              //   child: Text(
                              //     '\$' * widget.restaurant.price,
                              //     style: TextStyle(
                              //         fontSize: Theme.of(context)
                              //             .textTheme
                              //             .caption
                              //             .fontSize),
                              //   ),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              '${widget.restaurant.category} ● ${widget.restaurant.city}',
                              style: TextStyle(fontSize: 8, color: Colors.grey
                                  // fontSize:
                                  //     Theme.of(context).textTheme.caption.fontSize,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.restaurant.photo,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0x00000000),
                                  Color(0xAA000000),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _reviews.isNotEmpty && !_isLoading
                      ? SliverPadding(
                          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(_reviews
                                .map((Review review) =>
                                    RestaurantReview(review: review))
                                .toList()),
                          ),
                        )
                      : SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyListView(
                            child: Text(
                                'Seems like ${_restaurant.name} has no reviews.'),
                            onPressed: _onAddRandomReviewsPressed,
                          ),
                        ),
                ],
              )),
    );
  }
}
