import 'package:flutter/material.dart';
import '../../../state/misc_state.dart';
import '../../../utils/app_theme.dart';
import 'bottom_nav_bar_icon.dart';

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
          icon: BottomNavBarIcon(
            currentIndex: currentIndex,
            index: 0,
            icon: Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: BottomNavBarIcon(
            currentIndex: currentIndex,
            index: 1,
            icon: Icons.poll_outlined,
          ),
          label: 'Create Poll',
        ),
        BottomNavigationBarItem(
          icon: BottomNavBarIcon(
            currentIndex: currentIndex,
            index: 2,
            icon: Icons.person,
          ),
          label: 'Account',
        ),
      ],
    );
  }
}
