import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/screens/MainMenu.dart';
import 'package:kaffe/utils/constants.dart';
import '../../utils/size_config.dart';

class OnBoardingPage extends StatefulWidget {
  static const String route = 'intro_slider';
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int showCaseDots = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (int value) {
                  setState(() {
                    showCaseDots = value;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return ShowCaseContainer(
                    image: showCaseInfo[index]['image'],
                    title: showCaseInfo[index]['title'],
                    description: showCaseInfo[index]['description'],
                  );
                },
                itemCount: showCaseInfo.length,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(showCaseInfo.length,
                        (index) => buildShowCaseDots(index: index)),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  RoundButton(
                    onTap: () {
                      Navigator.pushNamed(context, MainMenu.route);
                      // FirebaseAuth.instance.signInAnonymously();
                    },
                    color: kPrimaryColor,
                    textColor: kWhiteColor,
                    title: 'GET STARTED',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildShowCaseDots({int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: showCaseDots == index ? 15 : 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              showCaseDots == index ? kPrimaryColor : const Color(0xffF9E6BF)),
    );
  }
}

class ShowCaseContainer extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  // ignore: use_key_in_widget_constructors
  const ShowCaseContainer(
      {@required this.image, @required this.title, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: SizedBox(
            height: getProportionateScreenHeight(200),
            width: double.infinity,
            child: Image(
              image: AssetImage(image),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: RichText(
              softWrap: true,
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$title\n\n',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: getProportionateScreenWidth(24),
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //   child:
        // ),
      ],
    );
  }
}
