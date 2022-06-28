import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  Timestamp? accountCreatedAt;
  
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.accountCreatedAt,
  });
}
