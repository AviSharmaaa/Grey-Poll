import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/vote_state.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/show_vote_list.dart';

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
      drawer: const DrawerWidget(),
      backgroundColor: Colors.teal.shade100,
      body: Column(children: const [
        ShowVoteList(),
      ]),
    );
  }
}
