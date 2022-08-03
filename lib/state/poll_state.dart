import 'package:flutter/material.dart';
import '../models/poll_model.dart';
import '../services/poll_database.dart';

class PollState extends ChangeNotifier {
  List<PollModel> _pollList = [];
  List<PollModel> _activePollList = [];
  List<PollModel> _pollsCreatedByUser = [];
  PollModel? _activePoll;
  String? _selectedOption;
  bool pollListAvailable = false;

  List<TextEditingController> _controllers = [];
  List<TextField> _textFields = [];

  void loadPollList() async {
    _activePollList = [];
    pollListAvailable = false;
    _pollList = await PollDatabase().getPollListFromFirestore();

    for (PollModel poll in _pollList) {
      if (poll.isActive!) {
        _activePollList.add(poll);
      }
    }

    setActivePollList = _activePollList;
  }

  void loadPollsCreatedByUser(String uid) {
    _pollsCreatedByUser = [];
    for (PollModel poll in _pollList) {
      if (poll.createdBy == uid) {
        _pollsCreatedByUser.add(poll);
      }
    }

    setPollsCreatedByUserList = _pollsCreatedByUser;
  }

  Future<String> disablePoll(String pollId) async {
    String response = "error";
    try {
      response = await PollDatabase().disablePoll(pollId);
      if (response == "success") {
        loadPollList();
      }
    } catch (e) {
      response = "Error!! Try Again Later";
    }
    return response;
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
      loadPollList();
      response = 'success';
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  void clearState() {
    _pollList = [];
    _activePoll = PollModel();
    _selectedOption = '';
  }

  //getter functions
  List<TextEditingController> get getTextEditingController => _controllers;
  List<TextField> get getTextField => _textFields;
  List<PollModel> get pollList => _pollList;
  List<PollModel> get activePollList => _activePollList;
  List<PollModel> get pollsCreatedByUser => _pollsCreatedByUser;
  PollModel? get getActivePoll => _activePoll;
  String? get getSelecetedOption => _selectedOption;

  //setter functions
  set setTextEditingControllers(value) {
    _controllers = value;
    notifyListeners();
  }

  set setTextField(value) {
    _textFields = value;
    notifyListeners();
  }

  set setActivePollList(value) {
    _activePollList = value;
    pollListAvailable = true;
    notifyListeners();
  }

  set setPollsCreatedByUserList(value) {
    _pollsCreatedByUser = value;
  }

  set setActivePoll(value) {
    _activePoll = value;
    notifyListeners();
  }

  set setSelectedOption(value) {
    _selectedOption = value;
    notifyListeners();
  }
}
