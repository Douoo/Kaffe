import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/screens/home/setting_page/forgot_password.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';

import 'signup_with_email.dart';

class LogInWithEmail extends StatefulWidget {
  const LogInWithEmail({Key key}) : super(key: key);
  static const String route = 'login_with_email';

  @override
  _LogInWithEmailState createState() => _LogInWithEmailState();
}

class _LogInWithEmailState extends State<LogInWithEmail> {
  FocusNode _focusOnEmailField;
  FocusNode _focusOnPasswordField;

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                // key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Login to continue',
                      style: Theme.of(context).textTheme.bodyText1,
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
                      focusNode: _focusOnPasswordField,
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureText,
                      onFieldSubmitted: (term) {
                        //TODO: add in the signin function
                        // fieldFocusChange(
                        //     context, _signinFunction, _focusOnEmailField);
                      },
                      decoration: kTextFieldDecoration.copyWith(
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
                    const SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPassword.route);
                      },
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    const TextBasedButton(
                      onPress: null,
                      placeholder: 'CONTINUE',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.caption,
                    children: [
                      const TextSpan(
                        text: 'Not yet registered? ',
                      ),
                      TextSpan(
                          text: 'Create account',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0,
                              color: kPrimaryColor,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                context, SignUpWithEmail.route)),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
