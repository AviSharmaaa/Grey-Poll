// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../models/poll_model.dart';
import '../../../state/poll_state.dart';
import '../../../utils/app_theme.dart';

class PollCard extends StatelessWidget {
  PollCard({
    Key? key,
    required this.provider,
    required this.poll,
    required this.index,
    required this.customFunction,
    required this.doesDisablePoll,
    this.customScreen,
    this.resultScreen,
  }) : super(key: key);

  final PollState provider;
  final PollModel poll;
  final int index;
  final Widget? resultScreen;
  final Widget? customScreen;
  final bool doesDisablePoll;
  final Function customFunction;
  final AppTheme theme = AppTheme();

  int calculateTotalVotes(PollModel poll) {
    int totalpolls = 0;
    poll.options!.forEach((key, value) {
      totalpolls += value as int;
    });
    return totalpolls;
  }

  void disablePoll(
      String pollId, ScaffoldMessengerState scaffoldMessenger) async {
    String response = "error";
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

  Color returnColor(PollModel poll, String activePollId) {
    Color color;
    if (activePollId == poll.pollId) {
      color = theme.kSecondaryColor2.withOpacity(0.8);
    } else {
      color = theme.kCanvasColor;
    }
    if (poll.isActive!) {
      (activePollId == poll.pollId)
          ? color = theme.kSecondaryColor2.withOpacity(0.8)
          : color = theme.kCanvasColor;
    } else {
      color = Colors.grey.shade200;
    }
    return color;
  }

  void showSnackBar(
    ScaffoldMessengerState scaffoldMessenger,
    bool doesDiablePoll,
    NavigatorState navigator,
  ) {
    if (doesDisablePoll == false) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Alreday participated. Displaying poll results"),
          duration: const Duration(milliseconds: 1000),
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 1500),
        () {
          navigator.push(
            MaterialPageRoute(builder: (context) => resultScreen!),
          );
        },
      );
    } else {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Double tap to disable poll"),
        ),
      );
    }
  }

  onTap(
    BuildContext context,
    ScaffoldMessengerState scaffoldMessenger,
    NavigatorState navigator,
  ) {
    provider.setActivePoll = poll;
    PollModel activePoll = provider.getActivePoll!;

    if (customFunction(activePoll.pollId)) {
      showSnackBar(scaffoldMessenger, doesDisablePoll, navigator);
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
  }

  @override
  Widget build(BuildContext context) {
    String activePollId = provider.getActivePoll?.pollId ?? '';

    int totalVotes = calculateTotalVotes(poll);
    String pollTitle = (poll.pollTitle!.length > 20)
        ? '${poll.pollTitle!.substring(0, 20)}...'
        : poll.pollTitle!;

    String description = (poll.description!.length >= 74)
        ? '${poll.description!.substring(0, 74)}...'
        : poll.description!;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
      child: InkWell(
        onTap: () {
          onTap(context, scaffoldMessenger, navigator);
        },
        onDoubleTap: () {
          (doesDisablePoll == true)
              ? disablePoll(activePollId, scaffoldMessenger)
              : null;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: returnColor(poll, activePollId),
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
                      style: activePollId == poll.pollId
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
                        color: activePollId == poll.pollId
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
                    color: activePollId == poll.pollId
                        ? theme.kWhiteText
                        : theme.kTextColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: activePollId == poll.pollId
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
