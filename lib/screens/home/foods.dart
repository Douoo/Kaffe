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
import 'package:kaffe/utils/size_config.dart';

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
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text("Popular Foods",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
          // centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Theme.of(context).iconTheme.color,
              ),
              // onPressed: () => _onFilterBarPressed(_filter),
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
                        return FoodCard(food: _foods[index]);
                      })
                  : EmptyListView(
                      child: Text('Kaffe has no Foods yet!'),
                      onPressed: _onAddRandomFoodsPressed,
                    ),
        ));
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key key,
    @required Food food,
  })  : _food = food,
        super(key: key);

  final Food _food;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
          child: SizedBox(
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_food.photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: null),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _food.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  //TODO: Insert the bookmarking logic here
                                },
                                child: const Icon(
                                  Icons.bookmark_outline,
                                  color: kPrimaryColor,
                                )),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${_food.category} ● ${_food.restaurant}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 10, color: Colors.grey),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              GestureDetector(
                                child: Icon(Icons.favorite_outline),
                                onTap: () {
                                  //TODO; favorite logic
                                },
                              ),
                              SizedBox(width: SizeConfig.screenWidth * 0.02),
                              GestureDetector(
                                child: Icon(Icons.insert_comment_outlined),
                                onTap: () {
                                  //TODO; favorite logic
                                },
                              ),
                              SizedBox(width: SizeConfig.screenWidth * 0.02),
                              GestureDetector(
                                child: Icon(Icons.share_location),
                                onTap: () {
                                  //TODO; favorite logic
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
      // onRestaurantPressed: ,
    );
  }
}
