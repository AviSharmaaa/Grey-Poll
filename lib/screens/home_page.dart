import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../state/vote_state.dart';
import '../widgets/show_vote_list.dart';
import 'root_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<VoteState>(context, listen: false).clearState();
      Provider.of<VoteState>(context, listen: false).loadVoteList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: const Text(
          'Home Screen',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Will prolly add logged in users details here later.'),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Page 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
            ),
            title: const Text('LogOut'),
            onTap: () async {
              CurrentUser currentUser =
                  Provider.of<CurrentUser>(context, listen: false);
              final navigator = Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RootScreen()), (route) => false);
              String response = await currentUser.signOut();

              if (response == "success") {
                navigator;
              }
            },
          ),
        ],
      ),
    ),
      backgroundColor: Colors.teal.shade100,
      body: Column(children: const [
        ShowVoteList(),
      ]),
    );
  }
}