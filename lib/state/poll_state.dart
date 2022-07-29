import 'package:flutter/material.dart';
import '../models/poll_model.dart';
import '../services/poll_database.dart';

class PollState extends ChangeNotifier {
  List<PollModel> _pollList = [];
  List<PollModel> _activePollList = [];
  List<PollModel> _pollsByCurrentUserList = [];
  PollModel? _activepoll;
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

  void loadPollList() async {
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
    for (PollModel poll in _pollList) {
      if (poll.createdBy == uid) {
        _pollsByCurrentUserList.add(poll);
      }
    }

    setPollsCreatedByUsersList = _pollsByCurrentUserList;
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
    _activepoll = PollModel();
    _selectedOption = '';
  }

  List<PollModel> get pollList => _pollList;
  List<PollModel> get activePollList => _activePollList;

  set setActivePollList(value) {
    _activePollList = value;
    pollListAvailable = true;
    notifyListeners();
  }

  set setPollsCreatedByUsersList(value) {
    _pollsByCurrentUserList = value;
    notifyListeners();
  }

  // set setpollList(value) {
  //   _pollList = value;
  //   pollListAvailable = true;
  //   notifyListeners();
  // }

  PollModel? get activepoll => _activepoll;
  String? get selecetedOption => _selectedOption;

  set activepoll(value) {
    _activepoll = value;
    notifyListeners();
  }

  set selectedOption(value) {
    _selectedOption = value;
    notifyListeners();
  }
}
