import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/card.dart';
import 'package:kaffe/components/list_empty.dart';
import 'package:kaffe/components/load_indicator.dart';
import 'package:kaffe/models/filter.dart';
import 'package:kaffe/models/food.dart';
import 'package:kaffe/models/restaurant.dart';
import 'package:kaffe/screens/home/restaurant_page.dart';
// import 'package:kaffe/screens/home/restaurant_page/filter_Foods.dart';
import 'package:kaffe/utils/constants.dart';

import '../../models/data.dart' as data;

class Foods extends StatefulWidget {
  static const String route = "Foods";
  const Foods({Key key}) : super(key: key);

  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  bool _isLoading = true;
  List<Food> _foods = [];
  StreamSubscription<QuerySnapshot> _currentSubscription;
  Filter _filter;

  void _updateFoods(QuerySnapshot snapshot) {
    setState(() {
      _isLoading = false;
      _foods = data.getFoodsFromQuery(snapshot);
    });
  }

  _FoodsState() {
    FirebaseAuth.instance
        .signInAnonymously()
        .then((UserCredential userCredential) {
      _currentSubscription = data.loadAllFoods().listen(_updateFoods);
    });
  }

  Future<void> _onAddRandomFoodsPressed() async {
    final numReviews = Random().nextInt(10) + 20;

    final foods = List.generate(numReviews, (_) => Food.random());
    print('$numReviews here are the doods $foods');
    data.addFoodsBatch(foods);
  }

  // Future<void> _onFilterBarPressed(Filter filterBy) async {
  //   final filter = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => FilterRestaurant(filter: filterBy),
  //     ),
  //   );

  // if (filter != null) {
  //   await _currentSubscription?.cancel();
  //   setState(() {
  //     _isLoading = true;
  //     _filter = filter;
  //     if (filter.isDefault) {
  //       _currentSubscription =
  //           data.loadAllFoods().listen(_updateFoods);
  //     } else {
  //       _currentSubscription =
  //           data.loadFilteredFoods(filter).listen(_updateFoods);
  //     }
  //   });
  // }

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
          title: Text("Foods", style: Theme.of(context).textTheme.bodyText1),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Theme.of(context).iconTheme.color,
            ),
            // onPressed: () => _onFilterBarPressed(_filter),
          ),
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
              : _foods.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foods.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                              child: SizedBox(
                                  height: 250,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    _foods[index].photo),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: null),
                                      ),
                                    ],
                                  ))),
                          // onRestaurantPressed: ,
                        );
                      })
                  : EmptyListView(
                      child: Text('Kaffe has no Foods yet!'),
                      onPressed: _onAddRandomFoodsPressed,
                    ),
        ));
  }
}
