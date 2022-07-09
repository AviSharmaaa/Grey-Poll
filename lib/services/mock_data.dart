import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vote_model.dart';
import '../state/vote_state.dart';
import 'database.dart';

class PollDatabase {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  void getVoteListFromFirestore(BuildContext context) async {
    await _firebase.collection('pollsDB').get().then((snapshot) {
      List<VoteModel> voteList = <VoteModel>[];

      for (var document in snapshot.docs) {
        voteList.add(mapFirestoreDocToVote(document));
      }

      Provider.of<VoteState>(context, listen: false).setVoteList = voteList;
    });
  }

  VoteModel mapFirestoreDocToVote(DocumentSnapshot document) {
    VoteModel vote = VoteModel(voteId: document.id);
    List<Map<String, dynamic>> poll = [];

    (document.data() as Map<String, dynamic>).forEach((key, value) {
      poll.add({key: value});
    });
   
    vote.voteTitle = poll[2]['title'];
    vote.createdBy = poll[1]['createdBy'];
    vote.options = poll[0]['Options'];

    return vote;
  }

  void markVote(VoteModel vote, String option, List<String> updatedList) async {
    Map<String, dynamic> updatedOptions = vote.options!;

    updatedOptions[option] = updatedOptions[option] + 1;
    await _firebase.collection('pollsDB').doc(vote.voteId).update({
      'Options': updatedOptions,
    });

    Database().updatePollParticipation(updatedList);
  }

  void retriveMarkedVoteFromFirestore(
      {String? voteId, BuildContext? context}) async {
    await _firebase.collection('pollsDB').doc(voteId).get().then((value) {
      Provider.of<VoteState>(context!, listen: false).activeVote =
          mapFirestoreDocToVote(value);
    });
  }

  void createPoll(String pollTitle, Map<String, dynamic> optionsList,
      String userId) async {
    await _firebase.collection('pollsDB').doc().set({
      'title': pollTitle,
      'createdBy': userId,
      'Options': optionsList,
    });
  }
  
}
