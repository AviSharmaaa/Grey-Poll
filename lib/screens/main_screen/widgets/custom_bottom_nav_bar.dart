import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

import '../../../state/misc_state.dart';
import '../../../utils/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.theme,
    required this.provider,
  }) : super(key: key);

  final int currentIndex;
  final MiscState provider;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        provider.setCurrentIndex = index;
      },
      currentIndex: currentIndex,
      type: BottomNavigationBarType.shifting,
      unselectedItemColor: theme.kSecondaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: ClayAnimatedContainer(
            duration: const Duration(milliseconds: 500),
            borderRadius: 200,
            width: (currentIndex == 0) ? 100 : 45,
            color: theme.kCanvasColor,
            height: 45,
            depth: (currentIndex == 0) ? 30 : 50,
            curveType: CurveType.concave,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.home,
                color: (currentIndex == 0)
                    ? theme.kPrimaryColor
                    : theme.kSecondaryColor2,
                size: (currentIndex == 0) ? 30 : 24,
              ),
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ClayAnimatedContainer(
            duration: const Duration(milliseconds: 500),
            borderRadius: 200,
            width: (currentIndex == 1) ? 100 : 45,
            height: 45,
            depth: (currentIndex == 1) ? 30 : 50,
            curveType: CurveType.concave,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.poll_outlined,
                color: (currentIndex == 1)
                    ? theme.kPrimaryColor
                    : theme.kSecondaryColor2,
                size: (currentIndex == 1) ? 30 : 24,
              ),
            ),
          ),
          label: 'Create Poll',
        ),
        BottomNavigationBarItem(
          icon: ClayAnimatedContainer(
            duration: const Duration(milliseconds: 500),
            borderRadius: 200,
            width: (currentIndex == 2) ? 100 : 45,
            height: 45,
            depth: (currentIndex == 2) ? 30 : 50,
            curveType: CurveType.concave,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.person,
                color: (currentIndex == 2)
                    ? theme.kPrimaryColor
                    : theme.kSecondaryColor2,
                size: (currentIndex == 2) ? 30 : 24,
              ),
            ),
          ),
          label: 'Account',
        ),
      ],
    );
  }
}
