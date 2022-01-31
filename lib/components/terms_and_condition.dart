import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/utils/constants.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.caption,
        children: [
          const TextSpan(
            text: 'By signing in, you agree with our ',
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
          const TextSpan(
            text: ' and ',
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
    );
  }
}
