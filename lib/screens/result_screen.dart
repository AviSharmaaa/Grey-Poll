// ignore_for_file: prefer_const_constructors

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vote_model.dart';
import '../services/mock_data.dart';
import '../state/vote_state.dart';
import 'home_page.dart';


class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    retriveActiveVoteData(context);
    VoteModel? activeVote =
        Provider.of<VoteState>(context, listen: false).activeVote;
    List<String> options = [];

    for (Map<String, int> option in activeVote!.options!) {
      option.forEach((title, value) {
        options.add(title);
      });
    }

    return Scaffold(
        backgroundColor: Colors.cyan.shade200,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        },
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 40,
                        )),
                    Center(
                      child: Text(
                        activeVote.voteTitle!,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child:
                    Text('Will add some design or something like that here :)'),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.white,
                child: createChart(context),
              ),
            ],
          ),
        ));
  }

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
      BuildContext context) {
    VoteModel? activeVote =
        Provider.of<VoteState>(context, listen: false).activeVote;

    List<VoteData> data = <VoteData>[];

    for (var option in activeVote!.options!) {
      option.forEach((key, value) {
        data.add(VoteData(option: key, total: value));
      });
    }

    return [
      charts.Series<VoteData, String>(
        id: 'VoteResult',
        colorFn: (_, pos) {
          if (pos! % 2 == 0) {
            return charts.MaterialPalette.green.shadeDefault;
          }
          return charts.MaterialPalette.blue.shadeDefault;
        },
        domainFn: (VoteData vote, _) => vote.option,
        measureFn: (VoteData vote, _) => vote.total,
        data: data,
      )
    ];
  }

  void retriveActiveVoteData(BuildContext context) {
    final voteId =
        Provider.of<VoteState>(context, listen: false).activeVote?.voteId;
    retriveMarkedVoteFromFirestore(voteId: voteId, context: context);
  }
}

class VoteData {
  String option = '';
  int total = 0;

  VoteData({
    required this.option,
    required this.total,
  });
}
