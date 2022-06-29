import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vote_model.dart';
import '../screens/vote_screen.dart';
import '../state/vote_state.dart';


class ShowVoteList extends StatelessWidget {
  const ShowVoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String activeVoteId =
        Provider.of<VoteState>(context, listen: true).activeVote?.voteId ?? '';

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
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VoteScreen()));
                    });
                  },
                  selected: activeVoteId == vote.voteId ? true : false,
                  onTap: () {
                    Provider.of<VoteState>(context, listen: false).activeVote =
                        vote;
                  },
                )),
        ],
      );
    });
  }
}
