import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';

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
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Get started with kaffe!',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w600),
              ),
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
                      obscureText: _isHidden,
                      decoration: kTextFieldDecoration.copyWith(
                        border: const UnderlineInputBorder(),
                        icon: const Icon(Icons.lock, color: Colors.grey),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: _isHidden
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: kPrimaryColor,
                                ),
                          onPressed: () {
                            setState(() => _isHidden = !_isHidden);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    TextBasedButton(
                      onPress: () {
                        //TODO: Add Signup Functionality
                      },
                      placeholder: "CONTINUE",
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF385499),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(FontAwesomeIcons.facebookF),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenHeight * 0.02),
                      CircularButton(
                        color: Colors.grey[300],
                        iconImage: 'assets/images/google-logo.png',
                        onTap: () {
                          //TODO: Implement google authentication
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Already have account? ',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextSpan(
                          text: 'Login',
                          style: Theme.of(context).textTheme.caption.copyWith(
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
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final Color color;
  final String iconImage;
  final Function onTap;
  const CircularButton({
    Key key,
    @required this.color,
    @required this.iconImage,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Image(
          image: AssetImage(iconImage),
        ),
      ),
    );
  }
}
