import 'package:flutter/material.dart';
import 'package:kaffe/utils/constants.dart';

class SavedRestaurants extends StatelessWidget {
  static const String route = "favorite";
  const SavedRestaurants({Key key}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child:
                Center(child: Image.asset("assets/images/list-is-empty.png")),
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
      ),
    );
  }
}
