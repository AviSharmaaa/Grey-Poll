import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import 'package:provider/provider.dart';
import '../../../models/poll_model.dart';
import '../../../models/user_model.dart';
import '../../../state/current_user_state.dart';
import '../../../state/poll_state.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/poll_card.dart';
import '../../poll_screen/poll_screen.dart';
import '../../results_screen.dart/result_screen.dart';

class ShowPollList extends StatelessWidget {
  ShowPollList({Key? key}) : super(key: key);

  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<CurrentUser>(
      context,
      listen: false,
    ).getCurrentUser;

    bool checkIfAlreadyvoted(pollId) {
      return (currentUser.participatedInPoll!.contains(pollId));
    }

    return Consumer<PollState>(
      builder: (context, provider, child) {
        return Visibility(
          visible: provider.pollListAvailable,
          replacement: Center(
            child: CircularProgressIndicator(
              color: theme.kPrimaryColor,
              backgroundColor: theme.color1,
            ),
          ),
          child: ListView.builder(
            itemCount: provider.activePollList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return  Padding(
                  padding: S.only(left: 18,top: 15),
                  child: const Text(
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
                customScreen: PollScreen(),
                resultScreen: ResultScreen(),
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
