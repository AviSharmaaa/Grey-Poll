import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/current_user_state.dart';
import '../../models/user_model.dart';
import '../../models/vote_model.dart';
import '../../services/user_database.dart';
import '../../services/poll_database.dart';
import '../../state/vote_state.dart';
import '../../utils/app_theme.dart';
import '../../widgets/snack_bar.dart';
import '../results_screen.dart/result_screen.dart';
import 'widgets/display_poll_details.dart';

class VoteScreen extends StatelessWidget {
  final AppTheme theme = AppTheme();

  bool isOptionSelected(BuildContext context) {
    if (Provider.of<VoteState>(context, listen: false)
            .selecetedOption
            ?.isEmpty ==
        true) {
      return false;
    }
    return true;
  }

  void castMyVote(BuildContext context, UserModel currentUser) {
    final VoteModel vote =
        Provider.of<VoteState>(context, listen: false).activeVote!;

    final selectedOption =
        Provider.of<VoteState>(context, listen: false).selecetedOption;

    List<String>? updatedList = currentUser.participatedInPoll;
    updatedList?.add(vote.voteId!);

    PollDatabase().markVote(vote, selectedOption!);
    Database().updatePollParticipation(updatedList!);
  }

  VoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoteModel? activeVote = Provider.of<VoteState>(context).activeVote;

    UserModel currentUser =
        Provider.of<CurrentUser>(context, listen: false).getCurrentUser;

    List<String> pollOptions = [];

    activeVote!.options!.forEach(
      (key, value) => pollOptions.add(key),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.kCanvasColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            'Confirm',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            if (isOptionSelected(context)) {
              castMyVote(context, currentUser);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => ResultScreen())));
            } else {
              showSnackBar(context, 'Please selecte an option and Try Again!!');
            }
          }),
      body: SingleChildScrollView(
        child: DisplayPollDetails(
          activeVote: activeVote,
          pollOptions: pollOptions,
        ),
      ),
    );
  }
}
