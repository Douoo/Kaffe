import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFEA5C2B);
const Color kSecondaryColor = Color(0xFFF6D860);
const Color kBoldColor = Color(0xFFFF7F3F);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kBlackColor = Color(0xFF000000);
const Color kTextFormFieldBorderColor = Color(0xFF082032);
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

fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

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
