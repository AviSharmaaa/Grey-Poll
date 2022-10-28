import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:online_voting_app/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../models/poll_model.dart';
import '../../../services/poll_database.dart';
import '../../../state/poll_state.dart';
import '../../../widgets/background_design.dart';
import 'poll_info.dart';

//Helper Class
class PollData {
  String option = '';
  int total = 0;

  PollData({
    required this.option,
    required this.total,
  });
}

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  final AppTheme theme = AppTheme();

  Widget createChart(BuildContext context, PollModel activePoll) {
    return Consumer<PollState>(
      builder: (context, value, child) {
        return charts.BarChart(
          retriveVoteResult(context, activePoll),
          animate: true,
        );
      },
    );
  }

  List<charts.Series<PollData, String>> retriveVoteResult(
    BuildContext context, PollModel activePoll
  ) {
    List<PollData> data = <PollData>[];

    activePoll.options!.forEach((key, value) {
      String option;
      (key.length > 12) ? option = "${key.substring(0, 9)}..." : option = key;
      data.add(PollData(option: option, total: value));
    });

    return [
      charts.Series<PollData, String>(
        id: 'PollResult',
        colorFn: (_, pos) {
          if (pos! % 2 == 0) {
            return charts.MaterialPalette.pink.shadeDefault;
          }
          return charts.MaterialPalette.purple.shadeDefault;
        },
        domainFn: (PollData vote, _) => vote.option,
        measureFn: (PollData vote, _) => vote.total,
        data: data,
      )
    ];
  }

  void retriveActivePollData(PollState provider, PollModel activePoll) async {
    final pollId = activePoll.pollId;

    provider.setActivePoll =
        await PollDatabase().retriveMarkedPollFromFirestore(pollId!);
  }

  @override
  Widget build(BuildContext context) {
    PollState provider = Provider.of<PollState>(context, listen: false);
    final PollModel activePoll = provider.getActivePoll!;
    retriveActivePollData(provider, activePoll);

    return Stack(
      children: [
        BackgroundDesign(
          shapeOneRight: S.percentWidth(-0.22)!,
          shapeOneTop: 0.12,
          shapeTwoLeft: 0.15,
          shapeTwoBottom: 0.05,
          shapeThreeLeft: 0.62,
          shapeThreeBottom: 0,
          shapeFourLeft: 0.03,
          shapeFourBottom: 45,
          sizedboxThreeHeight: S.percentHeight(0.435),
        ),
        Positioned(
          child: PollInfo(activePoll: activePoll),
        ),
        Positioned(
          bottom: S.height(0),
          child: Container(
            padding: S.all(20),
            width: S.percentWidth(1.0),
            height: S.percentHeight(0.45),
            color: theme.kCanvasColor,
            child: createChart(context, activePoll),
          ),
        ),
      ],
    );
  }
}
