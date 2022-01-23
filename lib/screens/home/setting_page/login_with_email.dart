import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/screens/home/setting_page/forgot_password.dart';
import 'package:kaffe/utils/constants.dart';

import 'signup_with_email.dart';

class LogInWithEmail extends StatefulWidget {
  const LogInWithEmail({Key key}) : super(key: key);
  static const String route = 'login_with_email';

  @override
  _LogInWithEmailState createState() => _LogInWithEmailState();
}

class _LogInWithEmailState extends State<LogInWithEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0.0,
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
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Form(
                // key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Login to continue',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
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
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ForgotPassword.route);
                          },
                          child: const Text(
                            'Forgot Password?',
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5,
                              color: kBlackColor,
                              height: 2.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
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
              const SizedBox(height: 15.0),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: 'Not yet registered? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.5,
                      color: Colors.black54,
                    ),
                  ),
                  TextSpan(
                      text: ' Create account',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: kPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, SignUpWithEmail.route);
                        }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
