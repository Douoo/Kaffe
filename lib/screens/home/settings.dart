// ignore_for_file: missing_required_param

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/utils/constants.dart';

import 'setting_page/signInPage.dart';

class Setting extends StatefulWidget {
  static const String route = "setting";
  const Setting({Key key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var darkModeState = true;
  var analyticsState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          flexibleSpace: Container(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        CircleAvatar(
                          backgroundColor: kBoldColor,
                          radius: 33.0,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 33.0,
                          ),
                        ),
                        SizedBox(
                          height: 13.0,
                        ),
                        Text(
                          'Not Signed In',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
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
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '    Sign In  ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                            Icon(
                              Icons.login_outlined,
                              color: kPrimaryColor,
                              size: 25,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignInPage.route);
                        },
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
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const Divider(),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text('Dark Mode'),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(top: 3.5),
                child: CupertinoSwitch(
                  value: darkModeState,
                  onChanged: (value) {
                    darkModeState = value;
                    setState(() {});
                  },
                  activeColor: kPrimaryColor,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text('Analytics'),
              ),
              subtitle: const Text(
                  'To provide you more personalized experince and improve product features, we track analytics about the app'),
              trailing: CupertinoSwitch(
                value: analyticsState,
                onChanged: (value) {
                  analyticsState = value;
                  setState(() {});
                },
                activeColor: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// SafeArea(
//       child: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             automaticallyImplyLeading: false,
//             floating: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Wrap(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(Icons.person),
//                       Text("Not signed in"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             expandedHeight: 140,
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 ListTile(
//                   title: Text("Dark mode"),
//                   trailing: Switch(),
//                 ),
//                 ListTile(
//                   title: Text("Send usage info"),
//                   subtitle: Text(
//                       'To provide you more personalized experince and improve product features, we track analytics about the app'),
//                   trailing: Switch(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     )
