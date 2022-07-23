import 'package:flutter/material.dart';

class AppTheme {
  final Color kCanvasColor = const Color(0xFFFFFFFF);
  final Color kTextColor = const Color(0xFF000000);
  final Color kPrimaryColor = const Color(0xFF7827E6);
  final Color kSecondaryColor = const Color(0xFF8D39EC);
  final Color kSecondaryColor2 = const Color(0xFFAA4FF6);
  final Color kSecondaryTextColor = Colors.grey.shade700;
  final Color color1 = const Color(0xFFEA80FC);
  final Color kWhiteText = const Color(0xFFFFFFFF);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: kCanvasColor,
      primaryColor: kPrimaryColor,
      colorScheme: ThemeData().colorScheme.copyWith(secondary: kSecondaryColor),
      scaffoldBackgroundColor: kCanvasColor,
      secondaryHeaderColor: kSecondaryTextColor,
      hintColor: kSecondaryTextColor,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: kSecondaryColor,
        suffixIconColor: kSecondaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 3.0,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: kSecondaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        minWidth: 200,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      iconTheme: IconThemeData(
        color: kSecondaryColor,
      ),
    );
  }
}
