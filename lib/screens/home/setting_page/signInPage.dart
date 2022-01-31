import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:kaffe/services/auth.dart';
=======
import 'package:kaffe/components/button.dart';
import 'package:kaffe/components/terms_and_condition.dart';
import 'package:kaffe/screens/home/setting_page/signup_with_email.dart';
>>>>>>> dd817cb55b171371ceb40be33e6550c22f736ee6
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';

import 'login_with_email.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);
  static const String route = 'signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('ACCOUNT', style: Theme.of(context).textTheme.bodyText1),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
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
<<<<<<< HEAD
                  ElevatedButton(
                    onPressed: () async {
                      dynamic res = await _authService.signInAnonymously();
                      if (res == null) {
                        print("not signed in");
                      } else {
                        print("signed in");
                        print(res);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white70),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Image(
                            image: AssetImage('assets/images/google-logo.png'),
                          ),
                          Text(
                            'CONTINUE WITH GOOGLE',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kBlackColor,
                              fontSize: 11.5,
                            ),
                          ),
                          Opacity(
                            opacity: 0.0,
                            child: Image(
                              image:
                                  AssetImage('assets/images/google-logo.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
=======
                  TextButtonWithIconImage(
                    buttonColor: Color(0xFFEEEEEE),
                    iconImage: 'assets/images/google-logo.png',
                    onPress: () {
                      //TODO: Google Signin
                    },
                    placeholder: 'CONTINUE WITH FACEBOOK',
                    placeholderColor: kBlackColor,
>>>>>>> dd817cb55b171371ceb40be33e6550c22f736ee6
                  ),
                  const SizedBox(height: 18.0),
                  const TextButtonWithIconImage(
                    buttonColor: Color(0xFF385499),
                    iconImage: 'assets/images/facebook-logo.png',
                    onPress: null,
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
    );
  }
}
