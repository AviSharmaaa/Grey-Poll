import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:online_voting_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../root_screen.dart';

Widget getStartedButton(BuildContext context, AppTheme theme) {
  void setVal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', true);
  }

  return GestureDetector(
    onTap: () {
      setVal();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const RootScreen(),
        ),
        (route) => false,
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: theme.kPrimaryColor,
        borderRadius: BorderRadius.circular(200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(3, 6),
          ),
        ],
      ),
      child: Padding(
        padding: S.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Text(
          "Get Started",
          style: TextStyle(
            fontSize: 22,
            color: theme.kWhiteText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
