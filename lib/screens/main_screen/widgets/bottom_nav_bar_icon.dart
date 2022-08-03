import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class BottomNavBarIcon extends StatelessWidget {
  BottomNavBarIcon({
    Key? key,
    required this.currentIndex,
    required this.icon,
    required this.index,
  }) : super(key: key);

  final int currentIndex;
  final IconData icon;
  final int index;
  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return ClayAnimatedContainer(
      duration: const Duration(milliseconds: 500),
      borderRadius: 200,
      width: (currentIndex == index) ? 100 : 45,
      height: 45,
      depth: (currentIndex == index) ? 30 : 50,
      curveType: CurveType.concave,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: (currentIndex == index)
              ? theme.kPrimaryColor
              : theme.kSecondaryColor2,
          size: (currentIndex == index) ? 30 : 24,
        ),
      ),
    );
  }
}
