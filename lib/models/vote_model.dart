class VoteModel {
  String? voteId;
  String? voteTitle;
  List<Map<String, int>>? options;

  VoteModel({
    this.voteId,
    this.voteTitle,
    this.options,
  });
}

// class Voter {
//   String? uid;
//   String? voteId;
//   int? markedVoteOption;

//   Voter({
//     this.uid,
//     this.voteId,
//     this.markedVoteOption,
//   });
// }
