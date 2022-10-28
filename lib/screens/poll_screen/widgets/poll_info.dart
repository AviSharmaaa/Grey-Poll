import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import '../../../models/poll_model.dart';

class PollInfo extends StatelessWidget {
  const PollInfo({
    Key? key,
    required this.size,
    required this.activePoll,
  }) : super(key: key);

  final Size size;
  final PollModel? activePoll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: S.symmetric(
        vertical: 10,
        horizontal: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(5, 8),
            ),
          ],
        ),
        width: S.width(size.width),
        child: Padding(
          padding: S.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activePoll!.pollTitle!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: S.height(15),
              ),
              const Text(
                'About',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: S.height(5),
              ),
              Text(
                activePoll!.description!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: S.height(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
