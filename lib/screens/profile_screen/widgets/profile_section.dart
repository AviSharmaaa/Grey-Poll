import 'package:flutter/material.dart';
import 'package:online_voting_app/screens/poll_activity/poll_activity_screen.dart';
import 'package:online_voting_app/state/poll_state.dart';
import 'package:provider/provider.dart';
import '../../../state/current_user_state.dart';
import '../../../models/user_model.dart';
import 'basic_info_container.dart';
import 'details_container.dart';
import 'info_container.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _nameKey = GlobalKey();

  final GlobalKey<FormState> _emailKey = GlobalKey();

  final GlobalKey<FormState> _passwordKey = GlobalKey();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PollState pollProvider = Provider.of<PollState>(context, listen: false);
    return Consumer<CurrentUser>(builder: (context, provider, value) {
      final UserModel user = provider.getCurrentUser;
      final int pollCount = (user.participatedInPoll != null)
          ? user.participatedInPoll!.length
          : 0;
      final int pollCreatedCount =
          (user.pollsCreated != null) ? user.pollsCreated!.length : 0;
      final int passwordLength = user.password!.length;
      final String obscureString = '*' * passwordLength;

      final String uid = user.uid!;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          children: <Widget>[
            BasicInfoContainer(user: user),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PollActivityScreen(
                    //       title: 'Poll participated',
                    //       pollsList: pollProvider.pollsCreatedByUser,
                    //     ),
                    //   ),
                    // );
                  },
                  child: InfoContainer(
                    count: pollCount,
                    title: 'Polls Participated',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PollActivityScreen(
                          title: 'Poll Created',
                          pollsList: pollProvider.pollsCreatedByUser,
                          userId: uid,
                        ),
                      ),
                    );
                  },
                  child: InfoContainer(
                      count: pollCreatedCount, title: 'Polls Created'),
                ),
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
              icon: Icons.lock_outline_sharp,
              provider: provider,
            ),
            const SizedBox(
              height: 40,
            ),
            DetailsContainer(
              formKey: _emailKey,
              controller: _emailController,
              title: 'Change Email',
              fieldName: 'Email',
              data: user.email!,
              icon: Icons.lock_outline_sharp,
              provider: provider,
            ),
            const SizedBox(
              height: 40,
            ),
            DetailsContainer(
              formKey: _passwordKey,
              controller: _passwordController,
              title: 'Change Password',
              fieldName: 'Password',
              data: obscureString,
              icon: Icons.lock_outline_sharp,
              provider: provider,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      );
    });
  }
}
