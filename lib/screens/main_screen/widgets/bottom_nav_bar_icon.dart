import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
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
      width: (currentIndex == index) ? S.width(100) : S.width(45),
      height: S.height(45),
      depth: (currentIndex == index) ? 30 : 50,
      curveType: CurveType.concave,
      child: Padding(
        padding: S.all(8),
        child: Icon(
          icon,
          color: (currentIndex == index)
              ? theme.kPrimaryColor
              : theme.kSecondaryColor2,
          size: (currentIndex == index) ? S.width(30) : S.width(24),
        ),
      ),
    );
  }
}
