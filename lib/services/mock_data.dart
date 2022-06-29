import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vote_model.dart';
import '../state/vote_state.dart';


List<VoteModel> getVoteList() {
  List<VoteModel> voteList = [];

  voteList
      .add(VoteModel(voteId: '123', voteTitle: 'Mobile Framework', options: [
    {'Flutter': 70},
    {'React': 40},
    {'Swift': 30}
  ]));
  voteList.add(VoteModel(voteId: '124', voteTitle: 'Web Framework', options: [
    {'Laravel': 70},
    {'React': 40},
    {'Angular': 30}
  ]));
  voteList.add(VoteModel(voteId: '125', voteTitle: 'Good Country', options: [
    {'India': 70},
    {'Indina': 40},
    {'Russia': 30},
    {'USA': 1}
  ]));

  return voteList;
}

const String kVotes = 'votes';
const String kTitle = 'title';

void getVoteListFromFirestore(BuildContext context) async {
 
  await FirebaseFirestore.instance.collection('pollsDB').get().then((snapshot) {
    List<VoteModel> voteList = <VoteModel>[];
    for (var document in snapshot.docs) {
      voteList.add(mapFirestoreDocToVote(document));
    }
    Provider.of<VoteState>(context, listen: false).voteList = voteList;
  });
}

VoteModel mapFirestoreDocToVote(DocumentSnapshot document) {
  VoteModel vote = VoteModel(voteId: document.id);
  List<Map<String, int>> options = [];

  (document.data() as Map<String, dynamic>).forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    } else {
      options.add({key: value});
    }
  });
  vote.options = options;
  return vote;
}

void markVote(String voteId, String option) async {
  await FirebaseFirestore.instance.collection('pollsDB').doc(voteId).update({
    option: FieldValue.increment(1),
  });
}

void retriveMarkedVoteFromFirestore(
    {String? voteId, BuildContext? context}) async {
  await FirebaseFirestore.instance
      .collection('pollsDB')
      .doc(voteId)
      .get()
      .then((value) {
    Provider.of<VoteState>(context!, listen: false).activeVote =
        mapFirestoreDocToVote(value);
  });
}
