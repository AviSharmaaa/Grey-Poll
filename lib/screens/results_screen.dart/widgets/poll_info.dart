import 'package:flutter/material.dart';
import '../../../models/vote_model.dart';

class PollInfo extends StatelessWidget {
  const PollInfo({
    Key? key,
    required this.size,
    required this.activeVote,
  }) : super(key: key);

  final Size size;
  final VoteModel? activeVote;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activeVote!.voteTitle!,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "About",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            activeVote!.description!,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
