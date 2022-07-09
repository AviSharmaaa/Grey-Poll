// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User currentUser = FirebaseAuth.instance.currentUser!;

  Future<String> createUser(UserModel user) async {
    String value = "error";

    try {
      await _firestore.collection("usersDB").doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'displayPicture':
            'https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/JiraiyaNarutomanga.jpg/150px-JiraiyaNarutomanga.jpg',
        'accountCreatedAt': Timestamp.now(),
        'participatedInPoll': [],
      });
      value = "success";
    } catch (e) {
      value = e.toString();
    }

    return value;
  }

  Future<UserModel> getUserInfo(String uid) async {
    UserModel currUser = UserModel();
    List<Map<String, dynamic>> currentUser = [];
    List<String>? pollsParticipated = [];
    String error = '';

    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("usersDB").doc(uid).get();

      (snapshot.data() as Map<String, dynamic>).forEach((key, value) {
        currentUser.add({key: value});
      });

      for (String id in currentUser[4]['participatedInPoll']) {
        pollsParticipated.add(id);
      }

      currUser.uid = uid;
      currUser.name = currentUser[3]['name'];
      currUser.password = currentUser[1]['password'];
      currUser.displayPicture = currentUser[0]['displayPicture'];
      currUser.participatedInPoll = pollsParticipated;
      currUser.email = currentUser[5]['email'];

      CurrentUser().setCurrentUser = currUser;
    } catch (e) {
      error = e.toString();
    }
    return currUser;
  }

  void updatePollParticipation(List<String> updatedArray) async {
    await FirebaseFirestore.instance
        .collection('usersDB')
        .doc(currentUser.uid)
        .update({
      'participatedInPoll': updatedArray,
    });
  }

  Future<String> updateUser(String name, String email, String password) async {
    String response = 'error';

    try {
      await FirebaseFirestore.instance
          .collection('usersDB')
          .doc(currentUser.uid)
          .update({
        'name': name,
        'email': email,
        'password': password,
      });
      response = 'success';
    } catch (e) {
      response = 'Something went wrong. Try Again Later!';
    }
    return response;
  }
}
