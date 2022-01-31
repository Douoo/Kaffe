// ignore_for_file: missing_required_param

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaffe/components/signin_widget.dart';
import 'package:kaffe/theme/theme_preference.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';
import 'package:provider/provider.dart';

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
    var themeProvider = Provider.of<ThemeProvider>(context);

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
            child: const NotSignedIn(),
          ),
        ),
      ),
      body: ListView(
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
        ],
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
