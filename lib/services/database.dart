import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_voting_app/models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(UserModel user) async {
    String value = "error";

    try {
      await _firestore.collection("usersDB").doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'accountCreatedAt': Timestamp.now(),
      });
      value = "success";
    } catch (e) {
      value = e.toString();
    }

    return value;
  }

  Future<UserModel> getUserInfo(String uid) async {
    UserModel currUser = UserModel();

    try {
      DocumentSnapshot dsnapshot =
          await _firestore.collection("usersDB").doc(uid).get();
      print(dsnapshot.data());
    } catch (e) {
      print(e);
    }
    return currUser;
  }
}
