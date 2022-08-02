import 'package:flutter/material.dart';
import 'package:online_voting_app/models/poll_model.dart';

import 'package:online_voting_app/utils/app_theme.dart';

import 'widgets/background_design.dart';
import 'widgets/show_polls_created_by_user.dart';

class PollActivityScreen extends StatelessWidget {
  final AppTheme theme = AppTheme();
  final String title;
  final List<PollModel> pollsList;
  final String userId;
  PollActivityScreen({
    Key? key,
    required this.title,
    required this.pollsList,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title),
        centerTitle: true,
        backgroundColor: theme.kPrimaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          BackgroundDesign(),
          ShowPollsCreatedByUser(),
        ],
      ),
    );
  }
}
