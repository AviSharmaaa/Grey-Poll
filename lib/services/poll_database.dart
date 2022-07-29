import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/poll_model.dart';
import '../state/poll_state.dart';

class PollDatabase {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<List<PollModel>> getPollListFromFirestore() async {
    List<PollModel> pollList = <PollModel>[];
    try {
      await _firebase.collection('pollsDB').get().then((snapshot) {
        for (var document in snapshot.docs) {
          pollList.add(mapFirestoreDocTopoll(document));
        }
      });
    } catch (e) {
      rethrow;
    }
    return pollList;
  }

  PollModel mapFirestoreDocTopoll(DocumentSnapshot document) {
    PollModel poll = PollModel(pollId: document.id);
    dynamic data = document.data();

    poll.pollTitle = data['title'];
    poll.description = data['description'];
    poll.createdBy = data['createdBy'];
    poll.options = data['Options'];
    poll.isActive = data['isActive'];

    return poll;
  }

  void markPoll(
    PollModel poll,
    String option,
  ) async {
    Map<String, dynamic> updatedOptions = poll.options!;

    updatedOptions[option] = updatedOptions[option] + 1;
    await _firebase.collection('pollsDB').doc(poll.pollId).update({
      'Options': updatedOptions,
    });
  }

  void retriveMarkedPollFromFirestore({
    String? pollId,
    BuildContext? context,
  }) async {
    await _firebase.collection('pollsDB').doc(pollId).get().then((value) {
      Provider.of<PollState>(context!, listen: false).activepoll =
          mapFirestoreDocTopoll(value);
    });
  }

  Future<String> createPoll(
    String pollId,
    String pollTitle,
    String description,
    Map<String, dynamic> optionsList,
    String userId,
  ) async {
    String response = 'error';
    try {
      final pollRef = _firebase.collection('pollsDB').doc(pollId);
      final newPoll = PollModel(
        pollTitle: pollTitle,
        description: description,
        createdBy: userId,
        options: optionsList,
        isActive: true,
      );

      final pollJson = newPoll.toJson();
      await pollRef.set(pollJson);
      response = 'success';
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
