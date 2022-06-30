import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vote_model.dart';
import '../state/vote_state.dart';
import 'database.dart';

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
    if (key == 'title') {
      vote.voteTitle = value;
    } else {
      options.add({key: value});
    }
  });
  vote.options = options;
  return vote;
}

void markVote(String voteId, String option, List<String> updatedList) async {
  await FirebaseFirestore.instance.collection('pollsDB').doc(voteId).update({
    option: FieldValue.increment(1),
  });

  Database().updatePollParticipation(updatedList);
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
