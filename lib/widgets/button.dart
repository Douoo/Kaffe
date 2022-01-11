import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {@required this.onTap,
      @required this.color,
      @required this.textColor,
      @required this.title});

  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
