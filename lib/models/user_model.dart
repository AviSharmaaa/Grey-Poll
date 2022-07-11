import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? displayPicture;
  Timestamp? accountCreatedAt;
  List<String>? participatedInPoll;
  List<String>? pollsCreated;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.displayPicture,
    this.accountCreatedAt,
    this.participatedInPoll,
    this.pollsCreated,
  });
}
