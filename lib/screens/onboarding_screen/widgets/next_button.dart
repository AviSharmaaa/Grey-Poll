import 'package:flutter/material.dart';

TextButton nextButton(PageController controller) {
  return TextButton(
    onPressed: () => controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
    style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF00BFA6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
    child: const Icon(
      Icons.chevron_right_sharp,
      size: 36,
      color: Colors.white,
    ),
  );
}
