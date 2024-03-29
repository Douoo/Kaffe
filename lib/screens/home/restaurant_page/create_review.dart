import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/models/review.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewCreateDialog extends StatefulWidget {
  final String userName;
  final String userId;

  ReviewCreateDialog({this.userName, this.userId, Key key});

  @override
  _ReviewCreateDialogState createState() => _ReviewCreateDialogState();
}

class _ReviewCreateDialogState extends State<ReviewCreateDialog> {
  double rating = 0;
  String review;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add a Review',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w400)),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 18, 0, 16),
            child: SmoothStarRating(
              starCount: 5,
              rating: rating,
              color: kSecondaryColor,
              borderColor: Colors.grey,
              size: 32,
              onRated: (value) {
                if (mounted) {
                  setState(() {
                    rating = value;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  TextField(
                    style: Theme.of(context).textTheme.bodyText2,
                    minLines: 5,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration.collapsed(
                      filled: true,
                      // fillColor: kWhiteColor,
                      hintText: 'Type your review here.',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (value) {
                      if (mounted) {
                        setState(() {
                          review = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    'Please try to be polite when giving your feedback to a restaurant. Any usage of explicit words might result in banning your account',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          RoundButton(
            onTap: () => Navigator.pop(
              context,
              Review.fromUserInput(
                rating: rating,
                text: review,
                userId: widget.userId,
                userName: widget.userName,
              ),
            ),
            color: kPrimaryColor,
            textColor: kWhiteColor,
            title: 'Submit',
          ),
          TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)))
        ],
      ),
    );
  }
}

// AlertDialog(
//       title: Text('Add a Review'),
//       content: Container(
//         width: math.min(MediaQuery.of(context).size.width, 740),
//         height: math.min(MediaQuery.of(context).size.height, 180),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
//               child: SmoothStarRating(
//                 starCount: 5,
//                 rating: rating,
//                 color: color,
//                 borderColor: Colors.grey,
//                 size: 32,
//                 onRated: (value) {
//                   if (mounted) {
//                     rating = value;
//                   }
//                 },
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 decoration: InputDecoration.collapsed(
//                     hintText: 'Type your review here.'),
//                 keyboardType: TextInputType.multiline,
//                 maxLines: null,
//                 onChanged: (value) {
//                   if (mounted) {
//                     setState(() {
//                       review = value;
//                     });
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: Text('CANCEL'),
//           onPressed: () => Navigator.pop(context, null),
//         ),
//         RaisedButton(
//           child: Text('SAVE'),
//           onPressed: () => Navigator.pop(
//             context,
//             Review.fromUserInput(
//               rating: rating,
//               text: review,
//               userId: widget.userId,
//               userName: widget.userName,
//             ),
//           ),
//         ),
//       ],
//     );
