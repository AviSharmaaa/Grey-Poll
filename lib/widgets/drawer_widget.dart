// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:online_voting_app/screens/profile_screen.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../screens/create_poll_screen.dart';
import '../screens/root_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user =
        Provider.of<CurrentUser>(context, listen: false).getCurrentUser;
    // final nameFirstLetter = user.name![0]
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.displayPicture!),
            ),
            accountEmail: Text(user.email!),
            accountName: Text(
              user.name!,
              style: const TextStyle(fontSize: 24.0),
            ),
            decoration: BoxDecoration(
              color: AppTheme().getSecondaryColor,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 38,
              color: AppTheme().getSecondaryTextColor,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                color: AppTheme().getSecondaryTextColor,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.poll_outlined,
              size: 38,
              color: AppTheme().getSecondaryTextColor,
            ),
            title: Text(
              'Create Poll',
              style: TextStyle(
                fontSize: 22,
                color: AppTheme().getSecondaryTextColor,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePollScreen(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              size: 38,
              color: AppTheme().getSecondaryTextColor,
            ),
            title: Text(
              'LogOut',
              style: TextStyle(
                fontSize: 22,
                color: AppTheme().getSecondaryTextColor,
              ),
            ),
            onTap: () async {
              CurrentUser currentUser =
                  Provider.of<CurrentUser>(context, listen: false);
              String response = await currentUser.signOut();

              if (response == "success") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const RootScreen()),
                    (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
