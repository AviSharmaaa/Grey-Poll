import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vote_model.dart';
import '../state/vote_state.dart';

class PollDatabase {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<List<VoteModel>> getVoteListFromFirestore() async {
    List<VoteModel> voteList = <VoteModel>[];
    await _firebase.collection('pollsDB').get().then((snapshot) {
      for (var document in snapshot.docs) {
        voteList.add(mapFirestoreDocToVote(document));
      }
    });
    return voteList;
  }

  VoteModel mapFirestoreDocToVote(DocumentSnapshot document) {
    VoteModel vote = VoteModel(voteId: document.id);
    List<Map<String, dynamic>> poll = [];

    (document.data() as Map<String, dynamic>).forEach((key, value) {
      poll.add({key: value});
    });

    vote.voteTitle = poll[3]['title'];
    vote.createdBy = poll[1]['createdBy'];
    vote.description = poll[2]['description'];
    vote.options = poll[0]['Options'];

    return vote;
  }

  void markVote(VoteModel vote, String option) async {
    Map<String, dynamic> updatedOptions = vote.options!;

    updatedOptions[option] = updatedOptions[option] + 1;
    await _firebase.collection('pollsDB').doc(vote.voteId).update({
      'Options': updatedOptions,
    });
  }

  void retriveMarkedVoteFromFirestore(
      {String? voteId, BuildContext? context}) async {
    await _firebase.collection('pollsDB').doc(voteId).get().then((value) {
      Provider.of<VoteState>(context!, listen: false).activeVote =
          mapFirestoreDocToVote(value);
    });
  }

  Future<String> createPoll(String pollId, String pollTitle, String description,
      Map<String, dynamic> optionsList, String userId) async {
    String response = 'error';
    try {
      await _firebase.collection('pollsDB').doc(pollId).set({
        'title': pollTitle,
        'description': description,
        'createdBy': userId,
        'Options': optionsList,
      });
      response = 'success';
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
