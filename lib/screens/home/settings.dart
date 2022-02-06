// ignore_for_file: missing_required_param

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/signin_widget.dart';
import 'package:kaffe/theme/theme_preference.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../onBoardingPage.dart';

class Setting extends StatefulWidget {
  static const String route = "setting";
  const Setting({Key key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _auth = FirebaseAuth.instance;
  final darkModeState = true;
  var analyticsState = true;
  // User user;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            getProportionateScreenHeight(250)), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          flexibleSpace: Container(
            padding: const EdgeInsets.all(18.0),
            child: !_auth.currentUser.isAnonymous
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        _auth.currentUser.displayName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        _auth.currentUser.email,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                : NotSignedIn(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Dark Mode', style: Theme.of(context).textTheme.button),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 3.5),
              child: CupertinoSwitch(
                value: themeProvider.darkTheme,
                onChanged: (value) {
                  setState(() {
                    themeProvider.darkTheme = !themeProvider.darkTheme;
                  });
                },
                activeColor: kPrimaryColor,
              ),
            ),
          ),
          const Divider(),
          // ignore: avoid_print
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child:
                  Text('Analytics', style: Theme.of(context).textTheme.button),
            ),
            subtitle: Text(
              'To provide you more personalized experince and improve product features, we track analytics about the app',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey),
            ),
            trailing: CupertinoSwitch(
              value: analyticsState,
              onChanged: (value) {
                analyticsState = value;
                setState(() {});
              },
              activeColor: kPrimaryColor,
            ),
          ),
          !_auth.currentUser.isAnonymous
              ? Column(
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text('Logout',
                          style: Theme.of(context).textTheme.button),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text('LOG OUT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                ),
                                content: const Text(
                                    'Are you sure you want to log out?',
                                    textAlign: TextAlign.center),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'CANCEL',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                      child: const Text(
                                        'YES',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () => () {
                                            _auth.signOut().then((_) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  OnBoardingPage.route,
                                                  (route) => false);
                                            });
                                          })
                                ],
                              );
                            });
                      },
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
