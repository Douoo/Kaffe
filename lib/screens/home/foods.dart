import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'food_page/comment_page.dart';

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

  //TODO: Change the _auth accessability through the AuthService class
  final _auth = FirebaseAuth.instance;

  void _updateFoods(QuerySnapshot snapshot) {
    setState(() {
      _isLoading = false;
      _foods = data.getFoodsFromQuery(snapshot);
    });
  }

  _FoodsState() {
    final user = _auth.currentUser;
    _currentSubscription = data.loadAllFoods().listen(_updateFoods);
    print('from the state ${user.uid}');
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
                        return FoodCard(
                            food: _foods[index], uid: _auth.currentUser.uid);
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
    @required String uid,
  })  : _food = food,
        _uid = uid,
        super(key: key);

  final Food _food;
  final _uid;

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
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              GestureDetector(
                                child: _food.isFavorite
                                    ? Icon(FontAwesomeIcons.solidHeart,
                                        color: kPrimaryColor)
                                    : Icon(FontAwesomeIcons.heart),
                                onTap: () {
                                  data.favoriteFood(
                                      foodId: _food.id,
                                      userId: _uid,
                                      isFavorite: _food.isFavorite);
                                },
                              ),
                              SizedBox(width: SizeConfig.screenWidth * 0.03),
                              GestureDetector(
                                child: Icon(FontAwesomeIcons.commentAlt),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommentScreen(
                                      food: _food,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeConfig.screenWidth * 0.03),
                              GestureDetector(
                                child: Icon(Icons.share_location),
                                onTap: () {
                                  //TODO; favorite logic
                                },
                              ),
                              Spacer(),
                              TextButton.icon(
                                icon: const Icon(
                                  Icons.location_pin,
                                  color: kSecondaryColor,
                                ),
                                label: Text(
                                  _food.restaurant,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onPressed: () {
                                  //TODO: Insert restaurant location fetch logic
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _food.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            _food.category,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 10, color: Colors.grey),
                          ),
                        ),
                        Text(_food.description,
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                ],
              ))),
      // onRestaurantPressed: ,
    );
  }
}
