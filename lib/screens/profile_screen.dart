import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../services/database.dart';
import '../utils/app_theme.dart';
import '../widgets/header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUser>(builder: (context, provider, child) {

      Database().getUserInfo(provider.currentUser.uid!);
      UserModel currentUser = provider.getCurrentUser;
      int pollsParticipated = (currentUser.participatedInPoll == null)
          ? 0
          : currentUser.participatedInPoll!.length;

      return Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 250,
                  child: Header(250, false, Icons.person),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 160, 25, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(currentUser.displayPicture!),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentUser.name!,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: AppTheme().getSecondaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  currentUser.email!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppTheme().getCanvasColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 15.0,
                          offset: Offset(
                            1.0,
                            2.0,
                          ),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Text(
                        pollsParticipated.toString(),
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w500,
                          color: AppTheme().getSecondaryTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Polls Participated',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: AppTheme().getTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Text(
                    "Note: To update your details please contact college's Student Departement.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                    backgroundColor: MaterialStateProperty.all(
                        AppTheme().getSecondaryColor2),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
