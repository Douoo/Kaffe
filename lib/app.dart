import 'package:flutter/material.dart';
import 'package:kaffe/screens/home/restaurant_page/filter_restaurants.dart';

import 'screens/MainMenu.dart';
import 'screens/home/restaurants.dart';
import 'screens/home/saved.dart';
import 'screens/home/settings.dart';
import 'screens/onBoardingPage.dart';

class Kaffe extends StatelessWidget {
  const Kaffe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaffe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: OnBoardingPage.route,
      routes: {
        OnBoardingPage.route: (context) => OnBoardingPage(),
        MainMenu.route: (context) => const MainMenu(),
        Restaurants.route: (context) => const Restaurants(),
        SavedRestaurants.route: (context) => const SavedRestaurants(),
        Setting.route: (context) => const Setting(),
        FilterRestaurant.route: (context) => const FilterRestaurant()
      },
    );
  }
}
