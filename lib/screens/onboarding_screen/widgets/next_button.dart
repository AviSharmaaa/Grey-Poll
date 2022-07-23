import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';

Widget nextButton(Key key, PageController controller, AppTheme theme) {
  return TextButton(
    key: key,
    onPressed: () => controller.nextPage(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    ),
    style: TextButton.styleFrom(
      backgroundColor: theme.kSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          color: theme.kWhiteText,
        )),
  );
}
