import 'package:flutter/material.dart';
import 'package:online_voting_app/state/misc_state.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:provider/provider.dart';
import '../create_poll_screen/create_poll_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AppTheme theme = AppTheme();

  List<Widget> screens = [
    const HomeScreen(),
    CreatePollScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MiscState>(builder: (context, misc, child) {
      int currentIndex = misc.getCurrentIndex;
      return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
            currentIndex: currentIndex, theme: theme, provider: misc),
      );
    });
  }
}

