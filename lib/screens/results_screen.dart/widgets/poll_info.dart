import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import '../../../models/poll_model.dart';

class PollInfo extends StatelessWidget {
  const PollInfo({
    Key? key,
    required this.activePoll,
  }) : super(key: key);

  final PollModel activePoll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: S.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      width: S.percentWidth(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activePoll.pollTitle!,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: S.height(12),
          ),
          const Text(
            "About",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: S.height(10),
          ),
          Text(
            activePoll.description!,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
