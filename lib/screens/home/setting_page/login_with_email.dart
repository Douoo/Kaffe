import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/screens/home/setting_page/forgot_password.dart';
import 'package:kaffe/screens/home/settings.dart';
import 'package:kaffe/screens/mainMenu.dart';
import 'package:kaffe/services/auth.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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

  AuthService _authService = AuthService();
  bool _isLoading = false;

  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
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
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w600),
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
                        controller: _emailFieldController,
                        onFieldSubmitted: (term) {
                          fieldFocusChange(context, _focusOnEmailField,
                              _focusOnPasswordField);
                        },
                        decoration: kTextFieldDecoration,
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        focusNode: _focusOnPasswordField,
                        textInputAction: TextInputAction.done,
                        controller: _passwordFieldController,
                        obscureText: _isHidden,
                        onFieldSubmitted: (term) {
                          // ignore: todo
                          //TODO: add in the signin function
                          // fieldFocusChange(
                          //     context, _signinFunction, _focusOnEmailField);
                        },
                        decoration: kTextFieldDecoration.copyWith(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ForgotPassword.route);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Forgot Password?',
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                      TextBasedButton(
                        onPress: () {
                          setState(() {
                            _isLoading = true;
                          });
                          _authService
                              .signInWithEmailAndPassword(
                                  _emailFieldController.text,
                                  _passwordFieldController.text)
                              .then((_) {
                            setState(() {
                              _isLoading = false;
                            });
                            print("user = ${_authService.username()}");
                            Navigator.pushNamed(context, Setting.route);
                          });
                        },
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
      ),
    );
  }
}
