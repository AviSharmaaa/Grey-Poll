import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/poll_model.dart';
import '../../../state/poll_state.dart';
import '../../../utils/app_theme.dart';
import 'display_options.dart';
import 'poll_info.dart';

class DisplayPollDetails extends StatelessWidget {
  final AppTheme theme = AppTheme();
  DisplayPollDetails({
    Key? key,
    required this.activePoll,
    required this.pollOptions,
  }) : super(key: key);

  final PollModel? activePoll;
  final List<String> pollOptions;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PollState provider = Provider.of<PollState>(context, listen: false);
    return Column(
      children: [
        PollInfo(size: size, activePoll: activePoll),
        const SizedBox(
          height: 20,
        ),
        for (String option in pollOptions)
          DisplayOptions(provider: provider, option: option),
      ],
    );
  }
}
