import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kaffe/utils/constants.dart';
import 'package:kaffe/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProgressIndicator extends StatelessWidget {
  // const ShimmerProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 270,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 10.0,
                                  color: Colors.white,
                                ),
                                Container(
                                  width: 40,
                                  height: 10.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 10.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  // const Loading({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: const Center(
        child: SpinKitCircle(
          color: kPrimaryColor,
          size: 50,
        ),
      ),
    );
  }
}
