import 'package:flutter/material.dart';
import 'package:kaffe/screens/home/setting_page/signInPage.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';

class NotSignedIn extends StatelessWidget {
  const NotSignedIn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  radius: 33.0,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 33.0,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  'Not Signed In',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: 50.0,
              margin: const EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                  width: 2.2,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: TextButton.icon(
                label: Text(
                  'Sign In  ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                icon: Icon(
                  Icons.login_outlined,
                  color: kPrimaryColor,
                  size: 25,
                ),
                onPressed: () => Navigator.pushNamed(context, SignInPage.route),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Sign in to start giving reviews and personalize your favorite foods and restaurants.',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
