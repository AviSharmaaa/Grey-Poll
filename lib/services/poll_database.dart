import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/poll_model.dart';

class PollDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PollModel>> getPollListFromFirestore() async {
    List<PollModel> pollList = <PollModel>[];
    try {
      await _firestore.collection('pollsDB').get().then((snapshot) {
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
    await _firestore.collection('pollsDB').doc(poll.pollId).update({
      'Options': updatedOptions,
    });
  }

  Future<PollModel> retriveMarkedPollFromFirestore(String pollId) async {
    PollModel poll;
    DocumentSnapshot snapshot =
        await _firestore.collection('pollsDB').doc(pollId).get();
    poll = mapFirestoreDocTopoll(snapshot);
    return poll;
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
      final pollRef = _firestore.collection('pollsDB').doc(pollId);
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

  Future<String> disablePoll(String pollId) async {
    String response = "error";

    try {
      await _firestore.collection("pollsDB").doc(pollId).update({
        'isActive': false,
      });
      response = "success";
    } catch (e) {
      response = "error";
    }
    return response;
  }
}
