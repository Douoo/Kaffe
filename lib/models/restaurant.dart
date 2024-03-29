import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './values.dart';

typedef RestaurantPressedCallback = void Function(String restaurantId);

typedef CloseRestaurantPressedCallback = void Function();

class Restaurant {
  final String id;
  final String name;
  final String category;
  final String city;
  final double avgRating;
  final int numRatings;
  bool isSaved;
  final int price;
  final String photo;
  final DocumentReference reference;

  Restaurant._(
      {this.name,
      this.category,
      this.city,
      this.price,
      this.photo,
      this.isSaved = false})
      : id = null,
        numRatings = 0,
        avgRating = 0,
        reference = null;

  Restaurant.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot.data()['name'],
        category = snapshot.data()['category'],
        city = snapshot.data()['city'],
        avgRating = snapshot.data()['avgRating'].toDouble(),
        numRatings = snapshot.data()['numRatings'],
        isSaved = snapshot.data()['wishList'] == null
            ? false
            : (snapshot.data()['wishList'] as List<dynamic>)
                    .contains(FirebaseAuth.instance.currentUser.uid)
                ? true
                : false,
        price = snapshot.data()['price'],
        photo = snapshot.data()['photo'],
        reference = snapshot.reference;

  factory Restaurant.random() {
    // HERE AS THE METHOD ALREADY INDICATES WE ARE USING THE FACTORY METHOD TO CREATE RESTAURANTS
    return Restaurant._(
      category: getRandomCategory(),
      city: getRandomCity(),
      name: getRandomName(),
      price: Random().nextInt(3) + 1,
      photo: getRandomPhoto(),
    );
  }
}
