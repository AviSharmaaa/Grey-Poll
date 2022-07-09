class VoteModel {
  String? voteId;
  String? voteTitle;
  String? createdBy;
  Map<String, dynamic>? options;

  VoteModel({
    this.voteId,
    this.voteTitle,
    this.createdBy,
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
