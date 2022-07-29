import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/current_user_state.dart';
import '../../../models/user_model.dart';
import '../../../models/poll_model.dart';
import '../../../state/poll_state.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/alert_dialog.dart';
import '../../poll_screen/poll_screen.dart';

class PollCard extends StatelessWidget {
  PollCard({
    Key? key,
    required this.provider,
    required this.poll,
    required this.index,
  }) : super(key: key);

  final PollState provider;
  final PollModel poll;
  final int index;
  final AppTheme theme = AppTheme();
  

  @override
  Widget build(BuildContext context) {
    print(poll.pollId);
    UserModel currentUser = Provider.of<CurrentUser>(
      context,
      listen: false,
    ).getCurrentUser;
    String activepollId = provider.activepoll?.pollId ?? '';

    bool checkIfAlreadypolld(pollId) {
      return (currentUser.participatedInPoll!.contains(pollId));
    }

    int calculateTotalpolls(PollModel poll) {
      int totalpolls = 0;
      poll.options!.forEach((key, value) {
        totalpolls += value as int;
      });
      return totalpolls;
    }

    int totalpolls = calculateTotalpolls(poll);
    String pollTitle = (poll.pollTitle!.length > 20)
        ? '${poll.pollTitle!.substring(0, 10)}...'
        : poll.pollTitle!;
    String description = (poll.description!.length >= 74)
        ? '${poll.description!.substring(0, 74)}...'
        : poll.description!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
      child: InkWell(
        onTap: () {
          provider.activepoll = poll;
          
          if (checkIfAlreadypolld(provider.activepoll!.pollId)) {
            showAlertDialog(context);
          } else {
            Future.delayed(const Duration(milliseconds: 600), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PollScreen()));
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: activepollId == poll.pollId ? theme.kCanvasColor : Colors.grey.shade200,
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
                      pollTitle,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: activepollId == poll.pollId
                            ? FontWeight.w900
                            : FontWeight.w700,
                      ),
                    ),
                    Text(
                      'votes: $totalpolls',
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
