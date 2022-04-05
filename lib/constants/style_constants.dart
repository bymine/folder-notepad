import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_sqflite/constants/color_constants.dart';

const appBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  titleTextStyle: TextStyle(color: headingTextColor),
  iconTheme: IconThemeData(color: headingTextColor),
);

var textTheme = GoogleFonts.poppinsTextTheme()
    .apply(bodyColor: headingTextColor)
    .copyWith();

var bottomTheme = const BottomNavigationBarThemeData(
  backgroundColor: bottomAppbarBackgorund,
  selectedItemColor: primaryColor,
);

var floatingTheme =
    const FloatingActionButtonThemeData(backgroundColor: primaryColor);

var dividerTheme = const DividerThemeData(
  color: Colors.grey,
  thickness: 0.5,
);
