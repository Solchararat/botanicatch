import 'package:flutter/material.dart';

// GUIDELINES:
// lower number == lighter color (e.g, kGreenColor100 == light green)
// higher number == darker color (e.g, kGreenColor900 == dark green)

// Green color
const kGreenColor100 = Color(0xFFB5ECB5);
const kGreenColor200 = Color(0xFF37C779);
const kGreenColor300 = Color(0xFF2AFE58);
const kGreenColor400 = Color(0xFF3E8005);
const kGreenColor500 = Color(0xFF384A36);

// Gray color
const kGrayColor100 = Color(0xFFCBC9C9);
const kGrayColor150 = Color(0xFFC4C4C4); // TextFormField color w/ opacity
const kGrayColor200 = Color(0xFFB5BAB6); // TextFormField hintText color
const kGrayColor250 = Color(0xFFBCBCBC); // home screen, icon and font color
const kGrayColor300 = Color(0xFFC4C4C4);
const kGrayColorOpaque300 = Color(0x59C4C4C4);

// Blue color
const kBlueColor100 = Color(0xFF24D6FD);
const kBlueColor200 = Color(0xFF016590);

// Text Style
const kLargeTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 32,
  color: Colors.white,
);

const kMediumTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 24,
  color: Colors.white,
);

const kSmallTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 18,
  color: Colors.white,
);

const kXXSmallTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 14,
  color: Colors.white,
);

// Outline Border
const kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(50.0),
  ),
  borderSide: BorderSide.none,
);
