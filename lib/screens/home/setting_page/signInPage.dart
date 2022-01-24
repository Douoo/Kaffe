import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/screens/home/setting_page/signup_with_email.dart';
import 'package:kaffe/utils/constants.dart';

import 'login_with_email.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);
  static const String route = 'signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            size: 25.0,
            color: kBlackColor,
          ),
        ),
        title: const Text(
          'ACCOUNT',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: kBlackColor,
          ),
        ),
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
                  color: kBlackColor,
                  wordSpacing: 1.0,
                  letterSpacing: 0.5,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Easily manage your posts, favorite restaurants and more personalized settings.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                  color: kBlackColor,
                  height: 2.0,
                ),
              ),
              const SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LogInWithEmail.route);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Text(
                        'CONTINUE WITH EMAIL',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  ElevatedButton(
                    onPressed: () {},
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
                  ),
                  const SizedBox(height: 18.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF385499)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Image(
                            image:
                                AssetImage('assets/images/facebook-logo.png'),
                          ),
                          Text(
                            'CONTINUE WITH FACEBOOK',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: kWhiteColor,
                            ),
                          ),
                          Opacity(
                            opacity: 0.0,
                            child: Image(
                              image:
                                  AssetImage('assets/images/facebook-logo.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'By signing in, you agree with our ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: 'Terms ans Conditions',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: kPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // path to terms and conditions
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 3.0),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policies',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: kPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // path to privacy policies
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
