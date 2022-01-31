import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import './values.dart';

typedef RestaurantPressedCallback = void Function(String restaurantId);

typedef CloseRestaurantPressedCallback = void Function();

class Food {
  final String id;
  final String name;
  final String category;
  final String restaurant;
  final String restaurantID;
  final int likes;
  final int price;
  final String photo;
  final DocumentReference reference;

  Food._(
      {this.name,
      this.category,
      this.restaurant,
      this.price,
      this.photo,
      this.restaurantID})
      : id = null,
        likes = 0,
        reference = null;

  Food.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        name = snapshot.data()['name'],
        category = snapshot.data()['category'],
        restaurant = snapshot.data()['restaurant'],
        restaurantID = snapshot.data()['restaurant_id'],
        likes = snapshot.data()['likes'],
        price = snapshot.data()['price'],
        photo = snapshot.data()['photo'],
        reference = snapshot.reference;

  factory Food.random() {
    return Food._(
      category: getRandomCategory(),
      restaurant: getRandomName(),
      restaurantID: getRandomRestaurantId(),
      name: getRandomFoodName(),
      price: Random().nextInt(50) + 1,
      photo: getRandomPhoto(),
    );
  }
}
