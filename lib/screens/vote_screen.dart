// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../models/vote_model.dart';
import '../services/mock_data.dart';
import '../state/vote_state.dart';
import '../widgets/snack_bar.dart';
import 'home_page.dart';
import 'result_screen.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoteModel? activeVote = Provider.of<VoteState>(context).activeVote;
    UserModel currentUser =
        Provider.of<CurrentUser>(context, listen: false).getCurrentUser;
    List<String> options = [];

    for (Map<String, int> option in activeVote!.options!) {
      option.forEach((title, value) {
        options.add(title);
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            'Confirm',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (isOptionSelected(context)) {
              castMyVote(context, currentUser);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ResultScreen())));
            } else {
              showSnackBar(context, 'Please selecte an option and Try Again!!');
            }
          }),
      backgroundColor: Colors.amberAccent.shade100,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              height: 100,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        },
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 40,
                        )),
                    Text(
                      activeVote.voteTitle!,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
          for (String option in options)
            InkWell(
              onTap: () {
                Provider.of<VoteState>(context, listen: false).selectedOption =
                    option;
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (Provider.of<VoteState>(context, listen: false)
                                .selecetedOption ==
                            option)
                        ? Colors.green
                        : Colors.white,
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option,
                            style: TextStyle(fontSize: 20),
                          ),
                          if (Provider.of<VoteState>(context, listen: false)
                                  .selecetedOption ==
                              option)
                            Icon(
                              Icons.check_circle_outline_sharp,
                              color: Colors.white,
                            )
                        ]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool isOptionSelected(BuildContext context) {
    if (Provider.of<VoteState>(context, listen: false)
            .selecetedOption
            ?.isEmpty ==
        true) {
      return false;
    }
    return true;
  }

  void castMyVote(BuildContext context, UserModel currentUser) {
    final voteId =
        Provider.of<VoteState>(context, listen: false).activeVote?.voteId;

    final selectedOption =
        Provider.of<VoteState>(context, listen: false).selecetedOption;

    List<String>? updatedList = currentUser.participatedInPoll;
    updatedList?.add(voteId!);

    markVote(voteId!, selectedOption!, updatedList!);
  }
}
