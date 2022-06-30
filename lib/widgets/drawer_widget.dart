import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../screens/root_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user =
        Provider.of<CurrentUser>(context, listen: false).getCurrentUser;
    final nameFirstLetter = user.name![0];
    // print(user.password);
    // print(user.name);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  user.displayPicture!),
            ),
            accountEmail: Text(user.email!),
            accountName: Text(
              user.name!,
              style: const TextStyle(fontSize: 24.0),
            ),
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 38,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              size: 38,
            ),
            title: const Text(
              'LogOut',
              style: TextStyle(fontSize: 22),
            ),
            onTap: () async {
              CurrentUser currentUser =
                  Provider.of<CurrentUser>(context, listen: false);
              final navigator = Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RootScreen()),
                  (route) => false);
              String response = await currentUser.signOut();

              if (response == "success") {
                navigator;
              }
            },
          ),
        ],
      ),
    );
  }
}
