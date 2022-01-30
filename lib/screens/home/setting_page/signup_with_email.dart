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
  FocusNode _focusOnName;
  FocusNode _focusOnEmailField;
  FocusNode _focusOnPasswordField;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Sign Up',
          style: Theme.of(context).textTheme.bodyText1,
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
                      focusNode: _focusOnName,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        fieldFocusChange(
                            context, _focusOnName, _focusOnEmailField);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      focusNode: _focusOnEmailField,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        fieldFocusChange(
                            context, _focusOnEmailField, _focusOnPasswordField);
                      },
                      decoration: kTextFieldDecoration,
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      obscureText: _obscureText,
                      decoration: kTextFieldDecoration.copyWith(
                        border: const UnderlineInputBorder(),
                        icon: const Icon(Icons.lock, color: Colors.grey),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: _obscureText
                              ? Icon(Icons.hide_source, color: kPrimaryColor)
                              : Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                ),
                          onPressed: () {
                            setState(() => _obscureText = !_obscureText);
                          },
                        ),
                      ),
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
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Already have account? ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          TextSpan(
                              text: 'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: kPrimaryColor,
                                      decoration: TextDecoration.underline),
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
