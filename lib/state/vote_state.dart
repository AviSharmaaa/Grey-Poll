import 'package:flutter/material.dart';
import '../models/vote_model.dart';
import '../services/poll_database.dart';

class VoteState extends ChangeNotifier {
  List<VoteModel> _voteList = [];
  VoteModel? _activeVote;
  String? _selectedOption;
  bool pollListAvailable = false;

  List<TextEditingController> _controllers = [];
  List<TextField> _textFields = [];

  List<TextEditingController> get getTextEditingController => _controllers;
  List<TextField> get getTextField => _textFields;

  set setTextEditingControllers(value) {
    _controllers = value;
    notifyListeners();
  }

  set setTextField(value) {
    _textFields = value;
    notifyListeners();
  }

  void loadVoteList() async {
    pollListAvailable = false;
    setVoteList = await PollDatabase().getVoteListFromFirestore();
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
      response = await PollDatabase()
          .createPoll(pollId, pollTitle, description, optionsList, userId);
      setVoteList = await PollDatabase().getVoteListFromFirestore();
      response = 'success';
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  void clearState() {
    _voteList = [];
    _activeVote = VoteModel();
    _selectedOption = '';
  }

  List<VoteModel> get voteList => _voteList;

  set setVoteList(value) {
    _voteList = value;
    pollListAvailable = true;
    notifyListeners();
  }

  VoteModel? get activeVote => _activeVote;
  String? get selecetedOption => _selectedOption;

  set activeVote(value) {
    _activeVote = value;
    notifyListeners();
  }

  set selectedOption(value) {
    _selectedOption = value;
    notifyListeners();
  }
}
