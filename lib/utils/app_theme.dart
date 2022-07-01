import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  final Color kCanvasColor = Colors.white;
  final Color kTextColor = Colors.grey.shade500;
  final Color kPrimaryColor = HexColor('#1916A5');
  final Color kSecondaryColor = HexColor('#110C66');
  final Color kSecondaryColor2 = HexColor('#4D56B9');
  final Color kSecondaryTextColor = HexColor('#446282');

  Color get getCanvasColor => kCanvasColor;
  Color get getTextColor => kTextColor;
  Color get getPrimaryColor => kPrimaryColor;
  Color get getSecondaryColor => kSecondaryColor;
  Color get getSecondaryColor2 => kSecondaryColor2;
  Color get getSecondaryTextColor => kSecondaryTextColor;

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: kCanvasColor,
      primaryColor: kPrimaryColor,
      colorScheme: ThemeData().colorScheme.copyWith(secondary: kSecondaryColor),
      scaffoldBackgroundColor: kCanvasColor,
      secondaryHeaderColor: kSecondaryTextColor,
      hintColor: kTextColor,
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: kSecondaryTextColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: kTextColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            width: 3.0,
            color: Colors.green.shade400,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: kSecondaryTextColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        minWidth: 200,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
