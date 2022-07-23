import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

Widget skipButton(PageController controller, AppTheme theme) {
  return InkWell(
    onTap: () => controller.animateToPage(
      duration: const Duration(milliseconds: 700),
      2,
      curve: Curves.easeInOut,
    ),
    child: Text(
      'Skip',
      style: TextStyle(
        fontSize: 18,
        color: theme.kSecondaryColor,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
