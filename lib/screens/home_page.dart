import 'package:flutter/material.dart';
import 'package:online_voting_app/screens/root_screen.dart';
import 'package:provider/provider.dart';

import '../models/current_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

 @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Hello",
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextButton(
            // onPressed: () {},
            onPressed: () async {
              CurrentUser currentUser =
                  Provider.of<CurrentUser>(context, listen: false);
              final navigator = Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RootScreen()), (route) => false);
              String response = await currentUser.signOut();

              if (response == "success") {
                navigator;
              }
            },
            child: Text(
              "Sign out".toUpperCase(),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );

  }
}




