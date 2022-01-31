import 'package:flutter/material.dart';
import 'package:kaffe/models/restaurant.dart';
import 'package:kaffe/models/star.dart';

class RestaurantAppBar extends StatelessWidget {
  static const double appBarHeight = 160;

  const RestaurantAppBar({
    this.restaurant,
    CloseRestaurantPressedCallback onClosePressed,
  }) : _onPressed = onClosePressed;

  final Restaurant restaurant;

  final CloseRestaurantPressedCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: _onPressed,
        icon: const Icon(Icons.close),
        iconSize: 32,
      ),
      expandedHeight: appBarHeight,
      forceElevated: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Wrap(
          children: <Widget>[
            Text(
              restaurant.name,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80,
                  alignment: Alignment.bottomLeft,
                  child: StarRating(
                    rating: restaurant.avgRating,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    '\$' * restaurant.price,
                    style: TextStyle(
                        fontSize: Theme.of(context).textTheme.caption.fontSize),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '${restaurant.category} ● ${restaurant.city}',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.caption.fontSize),
              ),
            ),
          ],
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              restaurant.photo,
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
    );
  }
}
