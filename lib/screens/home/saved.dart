import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/models/restaurant.dart';
import '../../models/data.dart' as data;
import 'package:kaffe/utils/constants.dart';

class SavedRestaurants extends StatefulWidget {
  static const String route = "favorite";
  const SavedRestaurants({Key key}) : super(key: key);

  @override
  State<SavedRestaurants> createState() => _SavedRestaurantsState();
}

class _SavedRestaurantsState extends State<SavedRestaurants> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = true;
  List<Restaurant> _restaurants = [];
  StreamSubscription<QuerySnapshot> _currentSubscription;

  void _updateRestaurants(QuerySnapshot snapshot) {
    setState(() {
      _isLoading = false;
      _restaurants = data.getRestaurantsFromQuery(snapshot);
      _restaurants =
          _restaurants.where((restaurant) => restaurant.isSaved).toList();
      print('the lenght of this restaurant ${_restaurants.length}');
    });
  }

  _SavedRestaurantsState() {
    final user = _auth.currentUser;

    if (user != null) {
      _currentSubscription =
          data.loadAllRestaurants().listen(_updateRestaurants);
    }

    // FirebaseAuth.instance
    //     .signInAnonymously()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Saved Places",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        centerTitle: true,
      ),
      body: !_restaurants.isEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _restaurants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Theme.of(context).cardColor,
                  leading: Hero(
                    tag: _restaurants[index].id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FadeInImage(
                        placeholder: const AssetImage(
                            'assets/images/load_placeholder.png'),
                        image: NetworkImage(_restaurants[index].photo),
                      ),
                    ),
                  ),
                  title: Text(_restaurants[index].name,
                      style: Theme.of(context).textTheme.headline6),
                  subtitle: Text(
                      "${_restaurants[index].category} | ${_restaurants[index].city}",
                      style: Theme.of(context).textTheme.caption),
                  trailing: IconButton(
                      icon: Icon(Icons.bookmark, color: kPrimaryColor),
                      onPressed: () {
                        data.saveRestaurant(
                          restaurantId: _restaurants[index].id,
                          userId: _auth.currentUser.uid,
                          isSaved: _restaurants[index].isSaved,
                        );
                      }),
                );
              })
          : NoSavedRestaurant(),
    );
  }
}

class NoSavedRestaurant extends StatelessWidget {
  const NoSavedRestaurant({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Center(child: Image.asset("assets/images/list-is-empty.png")),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.caption,
                children: [
                  TextSpan(
                      text: "Emm....No Favorites Yet\n\n",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(
                      text:
                          "You don't have any favorite restaurants yet. Try adding restaurants that you're interested in")
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
