import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../models/vote_model.dart';
import '../screens/vote_screen.dart';
import '../state/vote_state.dart';
import 'alert_dialog.dart';

class ShowVoteList extends StatelessWidget {
  const ShowVoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String activeVoteId =
        Provider.of<VoteState>(context, listen: true).activeVote?.voteId ?? '';
    UserModel currentUser =
        Provider.of<CurrentUser>(context, listen: false).getCurrentUser;

    bool checkIfAlreadyVoted(voteId) {
      if (currentUser.participatedInPoll!.contains(voteId)) {
        return true;
      }
      return false;
    }

    return Consumer<VoteState>(builder: (context, voteState, child) {
      return Column(
        children: <Widget>[
          for (VoteModel vote in voteState.voteList)
            Card(
                color:
                    activeVoteId == vote.voteId ? Colors.green : Colors.white,
                child: ListTile(
                  title: Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      vote.voteTitle!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onLongPress: () {
                    Provider.of<VoteState>(context, listen: false).activeVote =
                        vote;
                    if (checkIfAlreadyVoted(
                        Provider.of<VoteState>(context, listen: false)
                            .activeVote!
                            .voteId)) {
                      showAlertDialog(context);
                    } else {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VoteScreen()));
                      });
                    }
                  },
                  selected: activeVoteId == vote.voteId ? true : false,
                  // onTap: () {
                  //   Provider.of<VoteState>(context, listen: false).activeVote =
                  //       vote;
                  // },
                )),
        ],
      );
    });
  }
}
