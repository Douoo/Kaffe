import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/card.dart';
import 'package:kaffe/components/list_empty.dart';
import 'package:kaffe/components/load_indicator.dart';
import 'package:kaffe/models/filter.dart';
import 'package:kaffe/models/restaurant.dart';
import 'package:kaffe/screens/home/restaurant_page.dart';
import 'package:kaffe/screens/home/restaurant_page/filter_restaurants.dart';
import 'package:kaffe/utils/constants.dart';

import '../../models/data.dart' as data;

class Restaurants extends StatefulWidget {
  static const String route = "restaurants";
  const Restaurants({Key key}) : super(key: key);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  bool _isLoading = true;
  List<Restaurant> _restaurants = [];
  StreamSubscription<QuerySnapshot> _currentSubscription;
  Filter _filter;

  void _updateRestaurants(QuerySnapshot snapshot) {
    setState(() {
      _isLoading = false;
      _restaurants = data.getRestaurantsFromQuery(snapshot);
    });
  }

  _RestaurantsState() {
    _currentSubscription = data.loadAllRestaurants().listen(_updateRestaurants);
  }

  Future<void> _onAddRandomRestaurantsPressed() async {
    final numReviews = Random().nextInt(10) + 20;

    final restaurants = List.generate(numReviews, (_) => Restaurant.random());
    data.addRestaurantsBatch(restaurants);
  }

  Future<void> _onFilterBarPressed(Filter filterBy) async {
    final filter = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterRestaurant(filter: filterBy),
      ),
    );

    if (filter != null) {
      await _currentSubscription?.cancel();
      setState(() {
        _isLoading = true;
        _filter = filter;
        if (filter.isDefault) {
          _currentSubscription =
              data.loadAllRestaurants().listen(_updateRestaurants);
        } else {
          _currentSubscription =
              data.loadFilteredRestaurants(filter).listen(_updateRestaurants);
        }
      });
    }
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title:
              Text("Restaurant", style: Theme.of(context).textTheme.bodyText1),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => _onFilterBarPressed(_filter)),
          actions: [
            IconButton(
              onPressed: () {
                //TODO: insert the search function
              },
              icon: Icon(
                Icons.search_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
        body: Container(
          child: _isLoading
              ? ShimmerProgressIndicator()
              : _restaurants.isNotEmpty
                  ? ListView.builder(
                      itemCount: _restaurants.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                          restaurant: _restaurants[index],
                          onRestaurantPressed: (id) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestaurantPage(
                                        restaurant: _restaurants[index])));
                          },
                        );
                      })
                  : EmptyListView(
                      child: Text('Kaffe has no restaurants yet!'),
                      onPressed: _onAddRandomRestaurantsPressed,
                    ),
        ));
  }
}
