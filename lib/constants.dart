import 'package:flutter/material.dart';

const kLargeTitle = TextStyle(
  fontSize: 20,
  color: Colors.white,
);
const kMainTextButton = TextStyle(
  fontSize: 18,
  color: Colors.white,
);
const kSubTextButton = TextStyle(fontSize: 12, color: Colors.grey);
const kMediumTitle = TextStyle(fontSize: 16, color: Colors.white);
const kSmallTitle = TextStyle(fontSize: 14, color: Colors.white);
const kSubText = TextStyle(fontSize: 14, color: Colors.grey);
final kTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);
final InputDecoration kTextInputDecoration = InputDecoration(
    hintStyle: kSubText, labelStyle: kSubText, border: kTextInputBorder);
const kMainIcon = IconThemeData(color: Colors.white, size: 40);
const kInactiveIcon = IconThemeData(color: Colors.grey, size: 14);
const kActiveIcon = IconThemeData(color: Colors.deepOrange, size: 15);
