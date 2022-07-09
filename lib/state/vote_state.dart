import 'package:flutter/material.dart';
import '../models/vote_model.dart';
import '../services/mock_data.dart';

class VoteState extends ChangeNotifier {
  List<VoteModel> _voteList = [];
  VoteModel? _activeVote;
  String? _selectedOption;

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

  void loadVoteList(BuildContext context) async {
    PollDatabase().getVoteListFromFirestore(context);
  }

  void createPoll(BuildContext context,String pollTitle, Map<String ,dynamic> optionsList, String userId) {
    PollDatabase().createPoll(pollTitle, optionsList, userId);
    PollDatabase().getVoteListFromFirestore(context);
  }

  void clearState() {
    _voteList = [];
    _activeVote = VoteModel();
    _selectedOption = '';
  }

  List<VoteModel> get voteList => _voteList;

  set setVoteList(value) {
    _voteList = value;
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
