import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';
import 'get_started_button.dart';
import 'skip_button.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({
    Key? key,
    required this.isLastPage,
    required this.controller,
    required this.theme,
  }) : super(key: key);

  final bool isLastPage;
  final PageController controller;
  final AppTheme theme;

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  @override
  Widget build(BuildContext context) {
    Widget myAnimatedContainer = const SizedBox(
      width: 0,
    );
    setState(() {
      myAnimatedContainer = (widget.isLastPage)
          ? getStartedButton(context, widget.theme)
          : const SizedBox(
              width: 0,
            );
    });
    return Container(
      alignment: const Alignment(0, 0.90),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: (widget.isLastPage)
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceBetween,
          children: [
            if (!widget.isLastPage) skipButton(widget.controller, widget.theme),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              child: myAnimatedContainer,
            )
          ],
        ),
      ),
    );
  }
}
