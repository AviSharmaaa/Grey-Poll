import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/screens/results_screen.dart/result_screen.dart';
import 'package:provider/provider.dart';
import '../../../models/poll_model.dart';
import '../../../state/poll_state.dart';
import '../../../widgets/poll_card.dart';

class ShowPollsCreatedByUser extends StatelessWidget {
  ShowPollsCreatedByUser({Key? key}) : super(key: key);

  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Consumer<PollState>(
      builder: (context, provider, child) {
        provider.loadPollsCreatedByUser(firebaseUser!.uid);
        List<PollModel> pollsList = provider.pollsCreatedByUser;

        bool isPollActive(String id) {
          PollModel tappedPoll = PollModel();
          for (var poll in pollsList) {
            if (poll.pollId == id) {
              tappedPoll = poll;
              break;
            }
          }
          if (tappedPoll.isActive!) {
            return true;
          }
          return false;
        }

        

        return ListView.builder(
          itemCount: pollsList.length,
          itemBuilder: (context, index) {
            PollModel poll = pollsList[index];
            return PollCard(
              provider: provider,
              poll: poll,
              index: index,
              alertBoxTitle: "Disable Poll",
              alertBoxMessage: "Press OK to confirm to disable selected poll. Remember this action is irreversible.",
              pushWidgetOnTap: ResultScreen(),
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
