// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/database.dart';
import 'user_model.dart';

class CurrentUser extends ChangeNotifier {
  UserModel currentUser = UserModel();
  UserModel updatedUser = UserModel();

  UserModel get getCurrentUser => currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      final User firebaseUser = _auth.currentUser!;
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
      curruser.participatedInPoll = [];

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
        user.displayPicture = authResult.user!.photoURL;

        Database().createUser(user);
      }

      currentUser = await Database().getUserInfo(authResult.user!.uid);

      if (currentUser != null) {
        retVal = "success";
      }
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> updateName(String name) async {
    String response = 'error';
    try {
      await Database().updateUserName(name).then((val) {
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
      await firebaseUser.updateEmail(email).then((val) async {
        response = await Database().updateUserEmail(email);
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
      await firebaseUser.updatePassword(password).then((value) async {
        response = await Database().updateUserPassword(password);
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
