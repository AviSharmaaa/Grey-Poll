import 'package:flutter/material.dart';
import 'get_started_button.dart';
import 'next_button.dart';
import 'skip_button.dart';

Container navigationContainer(BuildContext context, PageController controller, bool isLastPage) {
  return Container(
    alignment: const Alignment(0, 0.90),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: (isLastPage)
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        children: [
          if (!isLastPage) skipButton(controller),
          (isLastPage) ? getStartedButton(context) : nextButton(controller),
        ],
      ),
    ),
  );
}
