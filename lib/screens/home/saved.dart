import 'package:flutter/material.dart';
import 'package:kaffe/utils/constants.dart';

class Favorite extends StatelessWidget {
  static const String route = "favorite";
  const Favorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "Favorite",
          style: TextStyle(color: Colors.black),
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
                text: const TextSpan(
                  style: TextStyle(color: kBlackColor),
                  children: [
                    TextSpan(
                        text: "Emm....No Favorites Yet\n",
                        style: TextStyle(
                            color: kBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
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
