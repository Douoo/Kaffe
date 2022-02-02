import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFEA5C2B);
const Color kSecondaryColor = Color(0xFFFF7F3F);
const Color kYellowColor = Color(0xFFF6D860);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kGreyColor = Color(0xFFEEEEEE);
const Color kBlackColor = Color(0xFF000000);
const Color kTextFormFieldBorderColor = Colors.grey;
const Color kFocusedTextFormFieldBorderColor = Color(0xFF878787);

final List<Map<String, String>> showCaseInfo = [
  {
    'image': 'assets/images/dining-serve-styled.png',
    'title': 'Explore the Best Restaurants',
    'description': 'Find out restaurants with best service and tasty food.',
  },
  {
    'image': 'assets/images/dining-serve-styled.png',
    'title': 'Connect With Others',
    'description':
        'Try our engaging question and answer forum. Ask and it will be answered',
  },
  {
    'image': 'assets/images/dining-serve.png',
    'title': 'Save Your Favorite Restaurant',
    'description':
        'Find the restaurant that suits your need best and we\'ll save it for you',
  },
  {
    'image': 'assets/images/dining-serve.png',
    'title': 'Think, Search or Filtere',
    'description':
        'Have a place in mind? All you need to do is search for it...or take a guess and filter it',
  }
];

const kSettingTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Roboto-Regular');
const kButtonTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto-Medium',
);

const InputDecoration kTextFieldDecoration = InputDecoration(
  labelText: 'Email',
  labelStyle: TextStyle(color: Colors.grey),
  focusColor: kPrimaryColor,
  hoverColor: kPrimaryColor,
  icon: Icon(
    Icons.email,
    color: Colors.grey,
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
      style: BorderStyle.solid,
    ),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kTextFormFieldBorderColor,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
  ),
);

fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Add a comment',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);

bool isInvalid(String value) {
  return value.contains("+") ||
      value.contains("_") ||
      value.contains("₩") ||
      value.contains("¥") ||
      value.contains("£") ||
      value.contains("€") ||
      value.contains("÷") ||
      value.contains("×") ||
      value.contains("€") ||
      value.contains("-") ||
      value.contains("(") ||
      value.contains(")") ||
      value.contains("*") ||
      value.contains("&") ||
      value.contains("^") ||
      value.contains("%") ||
      value.contains(" ") ||
      value.contains("#") ||
      value.contains("@") ||
      value.contains("!") ||
      value.contains("}") ||
      value.contains("{") ||
      value.contains("[") ||
      value.contains("]") ||
      value.contains(":") ||
      value.contains(";") ||
      value.contains("'") ||
      value.contains("\"") ||
      value.contains("\ ") ||
      value.contains("|") ||
      value.contains("<") ||
      value.contains(",") ||
      value.contains(">") ||
      value.contains(".") ||
      value.contains("/") ||
      value.contains("?") ||
      value.contains("~") ||
      value.contains("`");
}
