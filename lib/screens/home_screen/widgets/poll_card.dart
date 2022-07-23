import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/current_user_state.dart';
import '../../../models/user_model.dart';
import '../../../models/vote_model.dart';
import '../../../state/vote_state.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/alert_dialog.dart';
import '../../poll_screen/poll_screen.dart';

class PollCard extends StatelessWidget {
  PollCard({
    Key? key,
    required this.provider,
    required this.vote,
    required this.index,
  }) : super(key: key);

  final VoteState provider;
  final VoteModel vote;
  final int index;
  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<CurrentUser>(
      context,
      listen: false,
    ).getCurrentUser;
    String activeVoteId = provider.activeVote?.voteId ?? '';

    bool checkIfAlreadyVoted(voteId) {
      return (currentUser.participatedInPoll!.contains(voteId));
    }

    int calculateTotalVotes(VoteModel vote) {
      int totalVotes = 0;
      vote.options!.forEach((key, value) {
        totalVotes += value as int;
      });
      return totalVotes;
    }

    int totalVotes = calculateTotalVotes(vote);
    String voteTitle = (vote.voteTitle!.length > 20)
        ? '${vote.voteTitle!.substring(0, 10)}...'
        : vote.voteTitle!;
    String description = (vote.description!.length >= 74)
        ? '${vote.description!.substring(0, 74)}...'
        : vote.description!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
      child: InkWell(
        onTap: () {
          provider.activeVote = vote;
          
          if (checkIfAlreadyVoted(provider.activeVote!.voteId)) {
            showAlertDialog(context);
          } else {
            Future.delayed(const Duration(milliseconds: 600), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VoteScreen()));
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: activeVoteId == vote.voteId ? theme.kCanvasColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(7, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      voteTitle,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: activeVoteId == vote.voteId
                            ? FontWeight.w900
                            : FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Votes: $totalVotes',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "About",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
