import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User currentUser = FirebaseAuth.instance.currentUser!;

  Future<String> createUser(UserModel user) async {
    String value = "error";

    try {
      final userRef = _firestore.collection('usersDB').doc(user.uid);
      final newUser = UserModel(
        name: user.name,
        email: user.email,
        accountCreatedAt: user.accountCreatedAt,
        participatedInPoll: user.participatedInPoll,
        pollsCreated: user.pollsCreated,
      );
      final userJson = newUser.toJson();

      await userRef.set(userJson);
      value = "success";
    } catch (e) {
      value = e.toString();
    }

    return value;
  }

  Future<UserModel> getUserInfo(String uid) async {
    UserModel currUser = UserModel();
    List<String>? pollsParticipated = [];
    List<String>? pollsCreatedList = [];

    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("usersDB").doc(uid).get();

      dynamic data = snapshot.data();

      for (String id in data['participatedInPoll']) {
        pollsParticipated.add(id);
      }

      for (String id in data['pollsCreated']) {
        pollsCreatedList.add(id);
      }

      currUser.uid = uid;
      currUser.name = data['name'];
      currUser.email = data['email'];
      currUser.accountCreatedAt = data['accountCreatedAt'];
      currUser.participatedInPoll = pollsParticipated;
      currUser.pollsCreated = pollsCreatedList;
    } catch (e) {
      rethrow;
    }

    return currUser;
  }

  void updatePollParticipation(List<String> updatedArray) async {
    await _firestore.collection('usersDB').doc(currentUser.uid).update({
      'participatedInPoll': updatedArray,
    });
  }

  Future<String> updatePollsCreated(List<String> updatedList) async {
    String response = 'error';

    try {
      await _firestore.collection('usersDB').doc(currentUser.uid).update({
        'pollsCreated': updatedList,
      });
      response = 'success';
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updateUserName(String name) async {
    String response = 'error';

    try {
      await _firestore.collection('usersDB').doc(currentUser.uid).update({
        'name': name,
      });
      response = 'success';
    } catch (e) {
      response = 'Something went wrong. Try Again Later!';
    }
    return response;
  }

  Future<String> updateUserPassword(String password) async {
    String response = 'error';

    try {
      await _firestore.collection('usersDB').doc(currentUser.uid).update({
        'password': password,
      });
      response = 'success';
    } catch (e) {
      response = 'Something went wrong. Try Again Later!';
    }
    return response;
  }

  Future<String> updateUserEmail(String email) async {
    String response = 'error';

    try {
      await _firestore.collection('usersDB').doc(currentUser.uid).update({
        'email': email,
      });
      response = 'success';
    } catch (e) {
      response = 'Something went wrong. Try Again Later!';
    }
    return response;
  }
}
