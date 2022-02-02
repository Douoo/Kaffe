import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment.dart';
import 'filter.dart';
import 'food.dart';
import 'restaurant.dart';
import 'review.dart';

// This is the file that Codelab users will primarily work on.

Future<void> addRestaurant(Restaurant restaurant) {
  final restaurants = FirebaseFirestore.instance.collection('restaurants');
  return restaurants.add({
    'avgRating': restaurant.avgRating,
    'category': restaurant.category,
    'city': restaurant.city,
    'name': restaurant.name,
    'numRatings': restaurant.numRatings,
    'photo': restaurant.photo,
    'price': restaurant.price,
  });
}

Stream<QuerySnapshot> loadAllRestaurants() {
  return FirebaseFirestore.instance
      .collection('restaurants')
      .orderBy('avgRating', descending: true)
      .limit(50)
      .snapshots();
}

List<Restaurant> getRestaurantsFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Restaurant.fromSnapshot(doc);
  }).toList();
}

Future<Restaurant> getRestaurant(String restaurantId) {
  return FirebaseFirestore.instance
      .collection('restaurants')
      .doc(restaurantId)
      .get()
      .then((DocumentSnapshot doc) => Restaurant.fromSnapshot(doc));
}

Future<void> addReview({String restaurantId, Review review}) {
  final restaurant =
      FirebaseFirestore.instance.collection('restaurants').doc(restaurantId);
  final newReview = restaurant.collection('ratings').doc();

  return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
    return transaction
        .get(restaurant)
        .then((DocumentSnapshot doc) => Restaurant.fromSnapshot(doc))
        .then((Restaurant fresh) {
      final newRatings = fresh.numRatings + 1;
      final newAverage =
          ((fresh.numRatings * fresh.avgRating) + review.rating) / newRatings;

      transaction.update(restaurant, {
        'numRatings': newRatings,
        'avgRating': newAverage,
      });

      transaction.set(newReview, {
        'rating': review.rating,
        'text': review.text,
        'userName': review.userName,
        'timestamp': review.timestamp ?? FieldValue.serverTimestamp(),
        'userId': review.userId,
      });
    });
  });
}

Stream<QuerySnapshot> loadFilteredRestaurants(Filter filter) {
  Query collection = FirebaseFirestore.instance.collection('restaurants');
  if (filter.category != null) {
    collection = collection.where('category', isEqualTo: filter.category);
  }
  if (filter.city != null) {
    collection = collection.where('city', isEqualTo: filter.city);
  }
  if (filter.price != null) {
    collection = collection.where('price', isEqualTo: filter.price);
  }
  return collection
      .orderBy(filter.sort ?? 'avgRating', descending: true)
      .limit(50)
      .snapshots();
}

void addRestaurantsBatch(List<Restaurant> restaurants) {
  restaurants.forEach((Restaurant restaurant) {
    addRestaurant(restaurant);
  });
}

Future<void> addFood(Food food) {
  final foods = FirebaseFirestore.instance.collection('foods');
  return foods.add({
    'category': food.category,
    'restaurant': food.restaurant,
    'restaurant_id': food.restaurantID,
    'name': food.name,
    'photo': food.photo,
    'price': food.price,
    'likes': food.likes
  });
}

Stream<QuerySnapshot> loadAllFoods() {
  return FirebaseFirestore.instance
      .collection('foods')
      .orderBy('likes', descending: true)
      .limit(50)
      .snapshots();
}

List<Food> getFoodsFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Food.fromSnapshot(doc);
  }).toList();
}

Future<Food> getFood(String foodId) {
  return FirebaseFirestore.instance
      .collection('foods')
      .doc(foodId)
      .get()
      .then((DocumentSnapshot doc) => Food.fromSnapshot(doc));
}

void addFoodsBatch(List<Food> foods) {
  for (var food in foods) {
    addFood(food);
  }
}

//This is for adding the comments in the food

Future<void> addComment({String foodId, Comment comment}) {
  final food = FirebaseFirestore.instance.collection('foods').doc(foodId);
  final newComment = food.collection('comments').doc();

  return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
    return transaction
        .get(food)
        .then((DocumentSnapshot doc) => Food.fromSnapshot(doc))
        .then((Food fresh) {
      transaction.set(newComment, {
        'text': comment.text,
        'userName': comment.userName,
        'timestamp': comment.timestamp ?? FieldValue.serverTimestamp(),
        'userId': comment.userId,
      });
    });
  });
}

Future<void> favoriteFood({String foodId, String userId}) {
  final food = FirebaseFirestore.instance.collection('foods').doc(foodId);
  print("adding");
  food.update({
    "favorites": {userId: true}
  });
  print("added");
}
