import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../root_screen.dart';

TextButton getStartedButton(BuildContext context) {
  void setVal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', true);
  }

  return TextButton(
    onPressed: () {
      setVal();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RootScreen()),
          (route) => false);
    },
    style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF00BFA6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        "Get Started",
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
