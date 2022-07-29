import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/user_database.dart';
import '../models/user_model.dart';

class CurrentUser extends ChangeNotifier {
  UserModel currentUser = UserModel();

  UserModel get getCurrentUser => currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        currentUser = await Database().getUserInfo(firebaseUser.uid);
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> signOut() async {
    String value = "error";

    try {
      await _auth.signOut();
      currentUser = UserModel();
      value = "success";
    } catch (e) {
      value = e.toString();
    }
    return value;
  }

  Future<String> signUpUser(String email, String password, String name) async {
    String retVal = "error";
    UserModel curruser = UserModel();

    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      curruser.uid = authResult.user!.uid;
      curruser.email = authResult.user!.email;
      curruser.name = name;
      curruser.password = password;
      curruser.accountCreatedAt = Timestamp.now();
      curruser.participatedInPoll = [];
      curruser.pollsCreated = [];

      String response = await Database().createUser(curruser);

      if (response == "success") {
        retVal = "success";
      }
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> resetPassword(String email) async {
    String retVal = "error";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      retVal = "success";
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> loginInWithEmail(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      currentUser = await Database().getUserInfo(authResult.user!.uid);

      if (currentUser.uid != null) {
        retVal = "success";
      }
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> loginInWithGoogle(
    BuildContext context,
  ) async {
    String retVal = "error";

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    UserModel user = UserModel();

    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      UserCredential authResult = await _auth.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        user.uid = authResult.user!.uid;
        user.email = authResult.user!.email;
        user.name = authResult.user!.displayName;
        user.participatedInPoll = [];
        user.pollsCreated = [];

        Database().createUser(user);
      }

      currentUser = await Database().getUserInfo(authResult.user!.uid);
      retVal = "success";
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> updatePollsCreated(List<String> updatedList) async {
    String response = 'error';
    response = await Database().updatePollsCreated(updatedList);
    return response;
  }

  Future<String> updateName(String name) async {
    final User firebaseUser = _auth.currentUser!;
    String response = 'error';
    try {
      await Database().updateUserName(name).then((val) async {
        setCurrentUser = await Database().getUserInfo(firebaseUser.uid);
        response = 'success';
      });
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updateEmail(String email) async {
    String response = 'error';
    final User firebaseUser = _auth.currentUser!;

    try {
      await Database().updateUserEmail(email).then((value) async {
        await firebaseUser.updateEmail(email).then((value) async {
          setCurrentUser = await Database().getUserInfo(firebaseUser.uid);
          response = 'success';
        });
      });
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updatePassword(String password) async {
    String response = 'error';
    final User firebaseUser = _auth.currentUser!;

    try {
      await Database().updateUserPassword(password).then((value) async {
        await firebaseUser.updatePassword(password).then((value) async {
          setCurrentUser = await Database().getUserInfo(firebaseUser.uid);
          response = 'success';
        });
      });
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  set setCurrentUser(value) {
    currentUser = value;
    notifyListeners();
  }
}
