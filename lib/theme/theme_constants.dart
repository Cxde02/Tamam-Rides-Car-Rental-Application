// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

//Light Theme
const COLOR_PRIMARY = Color(0xFF0A486D);
//const COLOR_BOTTOMNAVBAR = Color(0xFF0a468d);
const COLOR_BOTTOMNAVBAR = Color(0xFF0A486D);
const COLOR_SEARCH_CONTAINER = Color(0xFFEBEBEB);
const COLOR_BOTTOMNAVBARCIRCLE = Color(0xFFDFE4DE);

const shimmerColorL = Color.fromARGB(255, 0, 0, 0);
const shimmerColorD = Color.fromARGB(255, 62, 130, 170);

//Dark Theme
const COLOR_BOTTOMNAVBARDARK = Color(0xFF1D506D);
const COLOR_BOTTOMNAVBARCIRCLEDARK = Color(0xFF0F1C33);

ThemeData lightTheme = ThemeData(
  //textTheme: TextTheme(bodyLarge: TextStyle(color: COLOR_BOTTOMNAVBAR)),
  primaryColor: Color(0xFFEBEBEB),
  //scaffoldBackgroundColor: COLOR_PRIMARY,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    selectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
    unselectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
    elevation: 20,
    backgroundColor: COLOR_BOTTOMNAVBAR,
    /*selectedItemColor: COLOR_BOTTOMNAVBARCIRCLE,
      unselectedItemColor: COLOR_BOTTOMNAVBARCIRCLE*/
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: COLOR_BOTTOMNAVBAR),
  ),

  brightness: Brightness.light,
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(COLOR_BOTTOMNAVBAR),
      foregroundColor: MaterialStatePropertyAll<Color>(Colors.red),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Color(0xFF12223E),
  scaffoldBackgroundColor: Color(0xFF12223E),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    selectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
    unselectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
    elevation: 20,
    backgroundColor: COLOR_BOTTOMNAVBARDARK,
    selectedItemColor: COLOR_BOTTOMNAVBARCIRCLEDARK,
    unselectedItemColor: COLOR_BOTTOMNAVBARCIRCLEDARK,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: COLOR_BOTTOMNAVBARDARK),
  ),
  brightness: Brightness.dark,
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(COLOR_BOTTOMNAVBARDARK),
      foregroundColor: MaterialStatePropertyAll<Color>(Colors.red),
    ),
  ),
);

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: Colors.blueGrey,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodBorderSide: const BorderSide(color: Colors.orange, width: 4),
  dayPeriodColor: Colors.blueGrey.shade600,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  dayPeriodTextColor: Colors.white,
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Colors.orange, width: 4),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Colors.orange
          : Colors.blueGrey.shade800),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? Colors.white : Colors.orange),
  dialHandColor: Colors.blueGrey.shade700,
  dialBackgroundColor: Colors.blueGrey.shade800,
  hourMinuteTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? Colors.orange : Colors.white),
  entryModeIconColor: Colors.orange,
);
