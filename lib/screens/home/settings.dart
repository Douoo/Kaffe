// ignore_for_file: missing_required_param

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/signin_widget.dart';
import 'package:kaffe/models/user.dart';
import 'package:kaffe/services/auth.dart';
import 'package:kaffe/theme/theme_preference.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'setting_page/signInPage.dart';

class Setting extends StatefulWidget {
  static const String route = "setting";
  const Setting({Key key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  AuthService _auth = AuthService();
  final darkModeState = true;
  var analyticsState = true;
  // User user;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    _auth.signInAnonymously;
    // final user = Provider.of<User>(context);
    print(_auth.username());
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              getProportionateScreenHeight(250)), // here the desired height
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(18.0),
              child: !_auth.isAnonyomus()
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
                          _auth != null ? '${_auth.username()}' : '',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _auth != null ? '${_auth.email()}' : '',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.bold),
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
              title:
                  Text('Dark Mode', style: Theme.of(context).textTheme.button),
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
                child: Text('Analytics',
                    style: Theme.of(context).textTheme.button),
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
            !_auth.isAnonyomus()
                ? Column(
                    children: [
                      const Divider(),
                      ListTile(
                        title: Text('Logout',
                            style: Theme.of(context).textTheme.button),
                        onTap: () {
                          setState(() {
                            _isLoading = true;
                          });
                          _auth.signOut().then((_) {
                            setState(() {
                              _isLoading = false;
                            });
                            print("user logged out");
                            Navigator.pushNamed(context, Setting.route);
                          });
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

// class ListTyle extends StatelessWidget {
//   const ListTyle({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Column(
//       children: [
//         const Divider(),
//         ListTile(
//           title: Text('Logout', style: Theme.of(context).textTheme.button),
//         ),
//       ],
//     );
//   }
// }
