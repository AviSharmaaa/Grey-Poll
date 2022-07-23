import 'package:flutter/material.dart';
import 'package:online_voting_app/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../state/current_user_state.dart';
import '../../utils/app_theme.dart';
import 'widgets/background_design.dart';
import 'widgets/profile_section.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    void setVal() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('showHome', false);
    }

    void justToAvoidAsynWarning(bool showHome) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => GreyPoll(
                  showHome: showHome,
                )),
        (route) => false,
      );
    }

    void retrunToMainScreen() async {
      final prefs = await SharedPreferences.getInstance();
      final bool showHome = prefs.getBool('showHome') ?? false;
      justToAvoidAsynWarning(showHome);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              size: 30,
            ),
            onPressed: () async {
              setVal();
              CurrentUser currentUser = Provider.of<CurrentUser>(
                context,
                listen: false,
              );
              String response = await currentUser.signOut();

              if (response == "success") {
                retrunToMainScreen();
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
        BackgroundDesign(),
        const SingleChildScrollView(
          child: ProfileSection(),
        ),
      ]),
    );
  }
}
