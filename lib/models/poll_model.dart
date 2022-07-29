class PollModel {
  String? pollId;
  String? pollTitle;
  String? createdBy;
  String? description;
  bool? isActive;
  Map<String, dynamic>? options;

  PollModel({
    this.pollId,
    this.pollTitle,
    this.createdBy,
    this.description,
    this.options,
    this.isActive,
  });

  Map<String, dynamic> toJson() => {
        'title': pollTitle,
        'createdBy': createdBy,
        'description': description,
        'Options': options,
        'isActive': isActive,
      };
}
