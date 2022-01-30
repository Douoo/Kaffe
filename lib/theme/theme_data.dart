import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaffe/utils/constants.dart';

class ThemeStyle {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    ThemeData _light = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
          elevation: 1.0,
          iconTheme: IconThemeData(color: kBlackColor),
          color: kWhiteColor),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.black,
      ),
      accentIconTheme: IconThemeData(
        color: Colors.grey[800],
      ),
      accentColor: Colors.black,

      brightness: Brightness.light,
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.orange),
          ),
        ),
      ),

      textTheme: const TextTheme(
          bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: "Roboto",
              fontWeight: FontWeight.normal),
          bodyText2: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14),
          headline1: TextStyle(
              fontSize: 96, color: Colors.black, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 60, color: Colors.black, fontWeight: FontWeight.w400),
          headline4: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 34,
              letterSpacing: 0.25),
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20,
            letterSpacing: 0.15,
            fontWeight: FontWeight.w400,
          ),
          subtitle1: TextStyle(fontSize: 16, color: Colors.grey),
          subtitle2: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
          caption: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
              letterSpacing: 0.4),
          button: TextStyle(color: Colors.black)),

      // primarySwatch: Colors.red,
      primaryColor: Colors.white,

      backgroundColor: Color(0xffF1F5FB),

      indicatorColor: Color(0xffCBDCF8),
      buttonColor: Color(0xffF1F5FB),

      highlightColor: Color(0xffFCE192),
      hoverColor: Color(0xff4285F4),

      focusColor: Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.light()),

      // primarySwatch: Colors.orange,
    );
    ThemeData _dark = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
          elevation: 1.0,
          iconTheme: IconThemeData(color: kWhiteColor),
          color: kBlackColor),
      accentColor: Colors.grey[500],
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
      accentIconTheme: IconThemeData(
        color: Colors.white,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.orange),
          ),
        ),
      ),
      cardColor: Colors.grey.shade900,
      textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: kWhiteColor, fontWeight: FontWeight.w300, fontSize: 16),
        bodyText2: TextStyle(
            color: kWhiteColor, fontWeight: FontWeight.w300, fontSize: 14),
        headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        headline4: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
        headline5: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 24,
            fontWeight: FontWeight.w400),
        subtitle1: TextStyle(color: Colors.grey, fontSize: 16),
        subtitle2: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        headline6: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 20,
            fontWeight: FontWeight.w400),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      ),
      // bottomAppBarColor: Colors.black87,
    );
    return isDarkTheme ? _dark : _light;
  }

  getCurrentNavigationBarColor(isDarkTheme) {
    if (isDarkTheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: const Color(0xFF26242e),
          systemNavigationBarIconBrightness: Brightness.light));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: const Color(0xFFFFFFFF),
          systemNavigationBarIconBrightness: Brightness.dark));
    }
  }
}
