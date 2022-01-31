import 'package:flutter/material.dart';
import 'package:kaffe/models/review.dart';
import 'package:kaffe/models/star.dart';

class RestaurantReview extends StatelessWidget {
  RestaurantReview({
    this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey,
          width: 1,
          style: BorderStyle.solid,
        ))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    review.userName,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.grey),
                  ),
                ),
                StarRating(rating: review.rating, size: 16),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Text(review.text ?? '',
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
