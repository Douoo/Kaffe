import 'package:flutter/material.dart';
import 'package:kaffe/screens/home/restaurant_page/filter_restaurants.dart';
import 'package:kaffe/screens/home/setting_page/forgot_password.dart';
import 'package:kaffe/screens/home/setting_page/login_with_email.dart';
import 'package:kaffe/screens/home/setting_page/signInPage.dart';
import 'package:kaffe/screens/home/setting_page/signup_with_email.dart';
import 'package:kaffe/theme/theme_preference.dart';
import 'package:provider/provider.dart' as provider;

import 'screens/MainMenu.dart';
import 'screens/home/food_page/comment_page.dart';
import 'screens/home/restaurants.dart';
import 'screens/home/saved.dart';
import 'screens/home/settings.dart';
import 'screens/onBoardingPage.dart';
import 'theme/theme_data.dart';

class Kaffe extends StatefulWidget {
  const Kaffe({Key key}) : super(key: key);

  @override
  State<Kaffe> createState() => _KaffeState();
}

class _KaffeState extends State<Kaffe> {
  final ThemeProvider _themeProvider = ThemeProvider();

  void getCurrentAppTheme() async {
    _themeProvider.darkTheme =
        await _themeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return provider.ChangeNotifierProvider(
      create: (_) {
        return _themeProvider;
      },
      child: provider.Consumer<ThemeProvider>(builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kaffe',
          theme: ThemeStyle.themeData(_themeProvider.darkTheme, context),
          initialRoute: OnBoardingPage.route,
          routes: {
            OnBoardingPage.route: (context) => OnBoardingPage(),
            MainMenu.route: (context) => const MainMenu(),
            Restaurants.route: (context) => const Restaurants(),
            SavedRestaurants.route: (context) => const SavedRestaurants(),
            Setting.route: (context) => const Setting(),
            FilterRestaurant.route: (context) => const FilterRestaurant(),
            SignInPage.route: (context) => const SignInPage(),
            SignUpWithEmail.route: (context) => const SignUpWithEmail(),
            LogInWithEmail.route: (context) => const LogInWithEmail(),
            ForgotPassword.route: (context) => const ForgotPassword(),
            CommentScreen.route: (context) => CommentScreen()
          },
        );
      }),
    );
  }
}
