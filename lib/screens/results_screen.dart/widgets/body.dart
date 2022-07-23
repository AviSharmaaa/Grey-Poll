import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../models/vote_model.dart';
import '../../../services/poll_database.dart';
import '../../../state/vote_state.dart';
import 'background_design.dart';
import 'poll_info.dart';

//Helper Class
class VoteData {
  String option = '';
  int total = 0;

  VoteData({
    required this.option,
    required this.total,
  });
}

class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.activeVote,
  }) : super(key: key);

  final VoteModel? activeVote;
  final AppTheme theme = AppTheme();

  Widget createChart(BuildContext context) {
    return Consumer<VoteState>(
      builder: (context, value, child) {
        return charts.BarChart(
          retriveVoteResult(context),
          animate: true,
        );
      },
    );
  }

  List<charts.Series<VoteData, String>> retriveVoteResult(
    BuildContext context,
  ) {
    VoteModel? activeVote = Provider.of<VoteState>(
      context,
      listen: false,
    ).activeVote;

    List<VoteData> data = <VoteData>[];

    activeVote!.options!.forEach((key, value) {
      data.add(VoteData(option: key, total: value));
    });

    return [
      charts.Series<VoteData, String>(
        id: 'VoteResult',
        colorFn: (_, pos) {
          if (pos! % 2 == 0) {
            return charts.MaterialPalette.pink.shadeDefault;
          }
          return charts.MaterialPalette.purple.shadeDefault;
        },
        domainFn: (VoteData vote, _) => vote.option,
        measureFn: (VoteData vote, _) => vote.total,
        data: data,
      )
    ];
  }

  void retriveActiveVoteData(BuildContext context) {
    final voteId = Provider.of<VoteState>(
      context,
      listen: false,
    ).activeVote?.voteId;
    PollDatabase().retriveMarkedVoteFromFirestore(
      voteId: voteId,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    retriveActiveVoteData(context);

    return Stack(
      children: [
        BackgroundDesign(),
        Positioned(
          // top: 0,
          child: PollInfo(size: size, activeVote: activeVote),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: size.width,
            height: size.height * 0.45,
            color: theme.kCanvasColor,
            child: createChart(context),
          ),
        ),
      ],
    );
  }
}
