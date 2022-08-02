import 'package:flutter/material.dart';
import 'package:online_voting_app/models/user_model.dart';
import 'package:online_voting_app/state/current_user_state.dart';
import 'package:provider/provider.dart';
import '../../../models/poll_model.dart';
import '../../../state/poll_state.dart';
import '../../../widgets/poll_card.dart';
import '../../poll_screen/poll_screen.dart';
import '../../results_screen.dart/result_screen.dart';

class ShowPollList extends StatelessWidget {
  const ShowPollList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel currentUser =
        Provider.of<CurrentUser>(context, listen: false).getCurrentUser;

    bool checkIfAlreadyvoted(pollId) {
      return (currentUser.participatedInPoll!.contains(pollId));
    }
    return Consumer<PollState>(
      builder: (context, provider, child) {
        return Visibility(
          visible: provider.pollListAvailable,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: provider.activePollList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 15.0),
                  child: Text(
                    'Ongoing Polls',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                );
              }
              PollModel poll = provider.activePollList[index - 1];
              return PollCard(
                provider: provider,
                poll: poll,
                index: index,
                alertBoxTitle: "See Results",
                alertBoxMessage:  "You have already participated in this poll. Would you like to see the results instead?",
                pushWidgetOnTap: ResultScreen(),
                customScreen: PollScreen(),
                customFunction: checkIfAlreadyvoted,
                doesDisablePoll: false,
              );
            },
          ),
        );
      },
    );
  }
}
