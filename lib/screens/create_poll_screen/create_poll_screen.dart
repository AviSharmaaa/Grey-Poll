// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:provider/provider.dart';
import '../../state/poll_state.dart';
import 'widgets/poll_form.dart';

class CreatePollScreen extends StatelessWidget {
  CreatePollScreen({Key? key}) : super(key: key);
  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Consumer<PollState>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Create a Poll'),
          centerTitle: true,
          backgroundColor: theme.kPrimaryColor,
          elevation: 0,
        ),
        body: Body(),
      );
    });
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: PollForm());
  }
}
