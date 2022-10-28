import 'package:flutter/material.dart';
import 'package:online_voting_app/main.dart';
import 'package:online_voting_app/utils/size_config.dart';
import 'package:online_voting_app/widgets/background_design.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../state/current_user_state.dart';
import '../../utils/app_theme.dart';
import 'widgets/profile_section.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final AppTheme theme = AppTheme();

  void setVal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', false);
  }

  void retrunToMainScreen(NavigatorState navigator) async {
    final prefs = await SharedPreferences.getInstance();
    final bool showHome = prefs.getBool('showHome') ?? false;
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => GreyPoll(
          showHome: showHome,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_outlined,
              size: S.width(30),
            ),
            onPressed: () async {
              final navigator = Navigator.of(context);
              setVal();
              CurrentUser currentUser = Provider.of<CurrentUser>(
                context,
                listen: false,
              );
              String response = await currentUser.signOut();

              if (response == "success") {
                retrunToMainScreen(navigator);
              }
            },
          ),
        ],
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: theme.kPrimaryColor,
        elevation: 0,
      ),
      body: Stack(children: [
        BackgroundDesign(
          shapeOneRight: S.percentWidth(-0.22)!,
          shapeOneTop: 0.12,
          shapeTwoLeft: 0.15,
          shapeTwoBottom: 0.05,
          shapeThreeLeft: 0.62,
          shapeThreeBottom: 0,
          shapeFourLeft: 0.03,
          shapeFourBottom: 45,
          sizedboxThreeHeight: S.percentHeight(0.50),
        ),
        const SingleChildScrollView(
          child: ProfileSection(),
        ),
      ]),
    );
  }
}
