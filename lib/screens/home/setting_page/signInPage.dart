import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/services/auth.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/components/terms_and_condition.dart';
import 'package:kaffe/screens/home/setting_page/signup_with_email.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../settings.dart';
import 'login_with_email.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);
  static const String route = 'signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('ACCOUNT', style: Theme.of(context).textTheme.bodyText1),
        ),
        body: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign in for the best experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Easily manage your posts, favorite restaurants and more personalized settings.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
                        height: 2.0,
                      ),
                ),
                const SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextBasedButton(
                      onPress: () =>
                          Navigator.pushNamed(context, LogInWithEmail.route),
                      placeholder: "CONTINUE WITH EMAIL",
                    ),
                    const SizedBox(height: 18.0),
                    TextButtonWithIconImage(
                      buttonColor: Color(0xFFEEEEEE),
                      iconImage: 'assets/images/google-logo.png',
                      onPress: () {
                        setState(() {
                          _isLoading = true;
                        });
                        _authService.signInWithGoogle().then((_) {
                          setState(() {
                            _isLoading = false;
                          });
                          print("user = ${_authService.username()}");
                          Navigator.pushNamed(context, Setting.route);
                        });
                      },
                      placeholder: 'CONTINUE WITH GOOGLE',
                      placeholderColor: kBlackColor,
                    ),
                    const SizedBox(height: 18.0),
                    TextButtonWithIconImage(
                      buttonColor: Color(0xFF385499),
                      iconImage: 'assets/images/facebook-logo.png',
                      onPress: () {
                        setState(() {
                          _isLoading = true;
                        });
                        _authService.signInWithFacebook().then((_) {
                          setState(() {
                            _isLoading = false;
                          });
                          print("user = ${_authService.username()}");
                          Navigator.pushNamed(context, Setting.route);
                        });
                      },
                      placeholder: 'CONTINUE WITH FACEBOOK',
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                const TermsCondition(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
