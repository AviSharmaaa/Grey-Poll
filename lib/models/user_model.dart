import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? accountCreatedAt;
  List<String>? participatedInPoll;
  List<String>? pollsCreated;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.accountCreatedAt,
    this.participatedInPoll,
    this.pollsCreated,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'accountCreatedAt': accountCreatedAt,
        'participatedInPoll': participatedInPoll,
        'pollsCreated': pollsCreated,
      };
}
