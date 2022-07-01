import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';

class ContainerWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  const ContainerWidget({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppTheme().getCanvasColor.withOpacity(0.4),
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: const Offset(
                4.0,
                4.0,
              ),
            ),
          ]),
      child: child,
    );
  }
}
