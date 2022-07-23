import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        'pollsCreated': [],
      });
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

    DocumentSnapshot snapshot =
        await _firestore.collection("usersDB").doc(uid).get();

    currUser.uid = uid;
    (snapshot.data() as Map<String, dynamic>).forEach((key, value) {
      if (key == 'displayPicture') {
        currUser.displayPicture = value;
      } else if (key == 'password') {
        currUser.password = value;
      } else if (key == 'name') {
        currUser.name = value;
      } else if (key == 'participatedInPoll') {
        for (String id in value) {
          pollsParticipated.add(id);
        }
        currUser.participatedInPoll = pollsParticipated;
      } else if (key == 'email') {
        currUser.email = value;
      } else if (key == 'pollsCreated') {
        for (String id in value) {
          pollsCreatedList.add(id);
        }
        currUser.pollsCreated = pollsCreatedList;
      }
    });
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
