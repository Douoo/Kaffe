import 'package:flutter/material.dart';
import 'package:kaffe/utils/constants.dart';

import '../models/restaurant.dart';
import '../models/star.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({
    this.restaurant,
    RestaurantPressedCallback onRestaurantPressed,
  }) : _onPressed = onRestaurantPressed;

  final Restaurant restaurant;

  final RestaurantPressedCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () => _onPressed(restaurant.id),
      splashColor: Colors.blue.withAlpha(30),
      child: SizedBox(
        height: 250,
        child: Column(
          children: <Widget>[
            // TODO: Make this a Hero widget so we can transition to it?
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(restaurant.photo),
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
                          restaurant.name,
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
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        OneStarRating(
                          rating: restaurant.avgRating,
                        ),
                        Text((restaurant.avgRating).toStringAsFixed(1)),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '${restaurant.category} ● ${restaurant.city}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 10, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
