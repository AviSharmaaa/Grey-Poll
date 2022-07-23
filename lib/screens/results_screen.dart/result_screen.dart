import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/vote_model.dart';
import '../../state/vote_state.dart';
import '../../utils/app_theme.dart';
import '../main_screen/main_screen.dart';
import 'widgets/body.dart';

class ResultScreen extends StatelessWidget {
  final AppTheme theme = AppTheme();
  ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoteModel? activeVote = Provider.of<VoteState>(
      context,
      listen: false,
    ).activeVote;

    List<String> options = [];

    activeVote!.options!.forEach((title, value) {
      options.add(title);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
                (route) => false);
          },
        ),
        elevation: 0,
      ),
      body: Body(activeVote: activeVote),
    );
  }
}
