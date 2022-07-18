import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

TextButton skipButton(PageController controller) {
  return TextButton(
    onPressed: () => controller.jumpToPage(2),
    child: Text(
      'Skip',
      style: TextStyle(
        fontSize: 18,
        color: AppTheme().getTextColor,
      ),
    ),
  );
}
