import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/poll_model.dart';
import '../../../state/poll_state.dart';
import '../../../widgets/poll_card.dart';
import '../../results_screen.dart/result_screen.dart';

class ShowPollsCreatedByUser extends StatelessWidget {
  ShowPollsCreatedByUser({Key? key}) : super(key: key);

  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Consumer<PollState>(
      builder: (context, provider, child) {
        provider.loadPollsCreatedByUser(firebaseUser!.uid);
        List<PollModel> pollsList = provider.pollsCreatedByUser;

        bool isPollActive(String pollId) {
          PollModel activePoll = provider.getActivePoll!;
          return activePoll.isActive!;
        }

        return ListView.builder(
          itemCount: pollsList.length,
          itemBuilder: (context, index) {
            PollModel poll = pollsList[index];
            return PollCard(
              provider: provider,
              poll: poll,
              index: index,
              customScreen: ResultScreen(),
              customFunction: isPollActive,
              doesDisablePoll: true,
            );
          },
        );
      },
    );
  }
}
