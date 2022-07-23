class VoteModel {
  String? voteId;
  String? voteTitle;
  String? createdBy;
  String? description;
  Map<String, dynamic>? options;

  VoteModel({
    this.voteId,
    this.voteTitle,
    this.createdBy,
    this.description,
    this.options,
  });
}