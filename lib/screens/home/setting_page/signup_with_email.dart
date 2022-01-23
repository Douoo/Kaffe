import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaffe/utils/constants.dart';

import 'login_with_email.dart';

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({Key key}) : super(key: key);
  static const String route = 'signup_with_email';

  @override
  _SignUpWithEmailState createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 2.0,
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
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: kBlackColor,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5.0),
              Form(
                // key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: Icon(Icons.person),
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        icon: const Icon(Icons.lock),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      obscureText: _obscureText,
                    ),
                    const SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 19.0, horizontal: 10.0),
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF385499),
                        radius: 25,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(FontAwesomeIcons.facebookF),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 25,
                        child: const Image(
                          image: AssetImage('assets/images/google-logo.png'),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 20.0),
                  // const Text(
                  //   'Already have account?',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w400,
                  //     fontSize: 11.0,
                  //     color: Colors.black54,
                  //     height: 2.0,
                  //   ),
                  // ),
                  // const SizedBox(height: 13.0),
                  // Container(
                  //   // height: 50.0,
                  //   margin: const EdgeInsets.only(bottom: 10.0),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: kPrimaryColor,
                  //       width: 2.2,
                  //     ),
                  //     borderRadius: BorderRadius.circular(6.0),
                  //   ),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, LogInWithEmail.route);
                  //     },
                  //     style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all(kWhiteColor),
                  //     ),
                  //     child: const Padding(
                  //       padding: EdgeInsets.symmetric(vertical: 19.0),
                  //       child: Text(
                  //         'Login',
                  //         style: TextStyle(
                  //           color: kPrimaryColor,
                  //           fontSize: 11.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Already have account? ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5,
                              color: Colors.black54,
                            ),
                          ),
                          TextSpan(
                              text: ' Login',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0,
                                color: kPrimaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, LogInWithEmail.route);
                                }),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
