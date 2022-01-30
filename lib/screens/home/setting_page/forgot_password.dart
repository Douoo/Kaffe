import 'package:flutter/material.dart';
import 'package:kaffe/components/button.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);
  static const String route = 'forgot_password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
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
                      'Forgot Password',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'Enter the email address associated with your Kaffe account and we will send you an email with instructions to reset your password.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    TextBasedButton(
                      onPress: () {
                        //TODO: Insert the forget password section here
                      },
                      placeholder: 'Continue',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
