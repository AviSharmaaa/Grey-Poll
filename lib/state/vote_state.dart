import 'package:flutter/material.dart';

import '../models/vote_model.dart';
import '../services/mock_data.dart';


class VoteState extends ChangeNotifier {
  List<VoteModel> _voteList = [];
  VoteModel? _activeVote;
  String? _selectedOption;

  void loadVoteList(BuildContext context) async {
    getVoteListFromFirestore(context);
  }

  void clearState() {
    _voteList = [];
    _activeVote = VoteModel();
    _selectedOption = '';
  }

  List<VoteModel> get voteList => _voteList;

  set voteList(value) {
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
