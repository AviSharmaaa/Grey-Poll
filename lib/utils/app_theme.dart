
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  final _primaryColor = HexColor('#DC54FE');
  final _accentColor = HexColor('#8A02AE');

  ThemeData buildTheme() {
    return ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey);
        // InputDecoration
  }
}
