// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:online_voting_app/widgets/snack_bar.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../utils/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyan.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: AppTheme().getCanvasColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(child: ProfileSection()),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _nameKey = GlobalKey();
  final GlobalKey<FormState> _emailKey = GlobalKey();
  final GlobalKey<FormState> _passwordKey = GlobalKey();

  ProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUser>(builder: (context, provider, value) {
      final UserModel user = provider.getCurrentUser;
      final int pollCount = user.participatedInPoll!.length;
      final int passwordLength = user.password!.length;
      final String obscureString = '*' * passwordLength;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.displayPicture!),
                radius: 60.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoContainer(
                    count: (pollCount == 0) ? 0 : pollCount,
                    title: 'Polls Participated'),
                const InfoContainer(count: 4, title: 'Polls Created'),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            DetailsContainer(
              formKey: _nameKey,
              controller: _nameController,
              title: 'Change Name',
              fieldName: 'Full Name',
              data: user.name!,
              provider: provider,
            ),
            const SizedBox(
              height: 30,
            ),
            DetailsContainer(
              formKey: _emailKey,
              controller: _emailController,
              title: 'Change Email',
              fieldName: 'Email',
              data: user.email!,
              provider: provider,
            ),
            const SizedBox(
              height: 30,
            ),
            DetailsContainer(
              formKey: _passwordKey,
              controller: _passwordController,
              title: 'Change Password',
              fieldName: 'Password',
              data: obscureString,
              provider: provider,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    });
  }
}

class DetailsContainer extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String title;
  final String fieldName;
  final String data;
  final CurrentUser provider;

  Future<String> updateName() async {
    String response = '';

    try {
      response = await provider.updateName(controller.text);
    } catch (e) {
      response = e.toString();
    }
    // print(controller.text);
    return response;
  }

  Future<String> updateEmail() async {
    String response;

    try {
      response = await provider.updateEmail(controller.text);
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updatePassword() async {
    String response;

    try {
      response = await provider.updatePassword(controller.text);
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  const DetailsContainer({
    Key? key,
    required this.title,
    required this.fieldName,
    required this.data,
    required this.controller,
    required this.formKey,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String response = '';
                      if (fieldName == 'Full Name') {
                        response = await updateName();
                      } else if (fieldName == 'Email') {
                        response = await updateEmail();
                      } else {
                        response = await updatePassword();
                      }
                      showSnackBar(context, response);
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.red, width: 2)),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 14),
              child: Row(
                children: [
                  Text(
                    fieldName,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            // SizedBox(height: 10,),
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: data,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field cannot be empty';
                  } else if (value == 'some data') {
                    return 'New $fieldName cannot be same as current';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final int count;
  final String title;
  const InfoContainer({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: [
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}
