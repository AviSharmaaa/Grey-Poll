import 'package:flutter/material.dart';
import '../../../models/poll_model.dart';
import '../../../state/poll_state.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/alert_dialog.dart';

class PollCard extends StatelessWidget {
  PollCard({
    Key? key,
    required this.provider,
    required this.poll,
    required this.index,
    required this.customFunction,
    required this.alertBoxTitle,
    required this.alertBoxMessage,
    required this.doesDisablePoll,
    required this.pushWidgetOnTap,
    this.customScreen,
  }) : super(key: key);

  final PollState provider;
  final PollModel poll;
  final int index;
  final String alertBoxTitle;
  final String alertBoxMessage;
  final Widget pushWidgetOnTap;
  final Widget? customScreen;
  final bool doesDisablePoll;
  final Function customFunction;
  final AppTheme theme = AppTheme();

 

  @override
  Widget build(BuildContext context) {
    String activepollId = provider.activepoll?.pollId ?? '';

    int calculateTotalVotes(PollModel poll) {
      int totalpolls = 0;
      poll.options!.forEach((key, value) {
        totalpolls += value as int;
      });
      return totalpolls;
    }

    

    void disablePoll(String pollId) async {
      String response = "error";
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      try {
        response = await provider.disablePoll(pollId);
      } catch (e) {
        response = e.toString();
      }
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(response),
        ),
      );
    }

    Color returnColor(PollModel poll) {
      Color color;

      if (activepollId == poll.pollId) {
        color = theme.kSecondaryColor2.withOpacity(0.8);
      } else {
        color = theme.kCanvasColor;
      }
      if (poll.isActive!) {
        (activepollId == poll.pollId)
            ? color = theme.kSecondaryColor2.withOpacity(0.8)
            : color = theme.kCanvasColor;
      } else {
        color = Colors.grey.shade200;
      }
      return color;
    }

     Future<void> disablePollOnTap(BuildContext context, PollModel activePoll) async {
      

      final response = await showDialog(context: context, builder: (context) => customAlertDialog(context, alertBoxTitle, alertBoxMessage, doesDisablePoll, pushWidgetOnTap));
      print(response);
      if (doesDisablePoll == true && response == true) {
        disablePoll(activePoll.pollId!);
      }
    }



    int totalVotes = calculateTotalVotes(poll);
    String pollTitle = (poll.pollTitle!.length > 20)
        ? '${poll.pollTitle!.substring(0, 20)}...'
        : poll.pollTitle!;
    String description = (poll.description!.length >= 74)
        ? '${poll.description!.substring(0, 74)}...'
        : poll.description!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
      child: InkWell(
        onTap: () async {
          // final scaffoldMessenger = ScaffoldMessenger.of(context);
          provider.activepoll = poll;
          PollModel activePoll = provider.activepoll!;

          if (customFunction(activePoll.pollId)) {
            disablePollOnTap(context,activePoll);
          } else {
            Future.delayed(
              const Duration(milliseconds: 600),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => customScreen!,
                  ),
                );
              },
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: returnColor(poll),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(5, 7),
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
                      style: activepollId == poll.pollId
                          ? TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: theme.kWhiteText,
                            )
                          : const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                    ),
                    Text(
                      'votes: $totalVotes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: activepollId == poll.pollId
                            ? theme.kWhiteText
                            : theme.kTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "About",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: activepollId == poll.pollId
                        ? theme.kWhiteText
                        : theme.kTextColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: activepollId == poll.pollId
                        ? theme.kWhiteText
                        : theme.kTextColor,
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
