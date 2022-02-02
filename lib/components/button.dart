import 'package:flutter/material.dart';
import 'package:kaffe/utils/constants.dart';

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

class TextButtonWithIconImage extends StatelessWidget {
  final String iconImage;
  final String placeholder;
  final Function onPress;
  final Color placeholderColor;
  final Color buttonColor;
  const TextButtonWithIconImage(
      {Key key,
      @required this.iconImage,
      @required this.placeholder,
      @required this.onPress,
      this.placeholderColor,
      @required this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(iconImage),
            ),
            Text(
              placeholder,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: placeholderColor ?? kWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextBasedButton extends StatelessWidget {
  final Function onPress;
  final String placeholder;
  const TextBasedButton(
      {Key key, @required this.onPress, @required this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Text(
          placeholder,
          style:
              Theme.of(context).textTheme.button.copyWith(color: kWhiteColor),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final Color color;
  final String iconImage;
  final Function onTap;
  const CircularButton({
    Key key,
    @required this.color,
    @required this.iconImage,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Image(
          image: AssetImage(iconImage),
        ),
      ),
    );
  }
}
