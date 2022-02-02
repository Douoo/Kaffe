import 'package:flutter/material.dart';
import 'package:kaffe/models/user.dart';
import 'package:kaffe/screens/home/saved.dart';
import 'package:kaffe/screens/home/settings.dart';
import 'package:kaffe/services/auth.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:provider/provider.dart';

import 'home/foods.dart';
import 'home/restaurants.dart';

class MainMenu extends StatefulWidget {
  static const String route = 'mainmenu';
  const MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentNavIndex = 0;
  final tabs = const [
    Foods(),
    Restaurants(),
    SavedRestaurants(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Foods'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: 'Restaurants'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
        currentIndex: _currentNavIndex,
        onTap: (int index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }
}
