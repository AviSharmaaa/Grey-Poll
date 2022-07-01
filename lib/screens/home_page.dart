import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/vote_state.dart';
import '../utils/app_theme.dart';
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            AppTheme().getSecondaryColor,
            AppTheme().getSecondaryColor2,
            Colors.blueAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'GreyPoll',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        drawer: const DrawerWidget(),
        backgroundColor: Colors.transparent,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 15, bottom: 7),
                child: Text(
                  'Active Polls',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ShowVoteList(),
            ]),
      ),
    );
  }
}
