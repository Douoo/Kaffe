import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  static const String route = "setting";
  const Setting({Key key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.person),
                      Text("Not signed in"),
                    ],
                  ),
                ],
              ),
            ),
            expandedHeight: 140,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: Text("Dark mode"),
                  trailing: Switch(),
                ),
                ListTile(
                  title: Text("Send usage info"),
                  subtitle: Text(
                      'To provide you more personalized experince and improve product features, we track analytics about the app'),
                  trailing: Switch(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
