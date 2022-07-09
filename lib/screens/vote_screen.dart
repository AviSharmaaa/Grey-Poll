import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../models/vote_model.dart';
import '../services/mock_data.dart';
import '../state/vote_state.dart';
import '../utils/app_theme.dart';
import '../widgets/container_widget.dart';
import '../widgets/snack_bar.dart';
import 'result_screen.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoteModel? activeVote = Provider.of<VoteState>(context).activeVote;

    UserModel currentUser = Provider.of<CurrentUser>(context, listen: false).getCurrentUser;

    List<String> pollOptions = [];

    activeVote!.options!.forEach(
      (key, value) => pollOptions.add(key),
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            AppTheme().getSecondaryColor,
            AppTheme().getSecondaryColor2,
            Colors.blueAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppTheme().getPrimaryColor,
            label: const Text(
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
                showSnackBar(
                    context, 'Please selecte an option and Try Again!!');
              }
            }),
        // backgroundColor: Colors.amberAccent.shade100,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                          )),
                      Text(
                        activeVote.voteTitle!,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
            for (String option in pollOptions)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Provider.of<VoteState>(context, listen: false)
                        .selectedOption = option;
                  },
                  child: ContainerWidget(
                    color: (Provider.of<VoteState>(context, listen: false)
                                .selecetedOption ==
                            option)
                        ? Colors.green
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            if (Provider.of<VoteState>(context, listen: false)
                                    .selecetedOption ==
                                option)
                              const Icon(
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
    final VoteModel vote =
        Provider.of<VoteState>(context, listen: false).activeVote!;

    final selectedOption =
        Provider.of<VoteState>(context, listen: false).selecetedOption;

    List<String>? updatedList = currentUser.participatedInPoll;
    updatedList?.add(vote.voteId!);

    PollDatabase().markVote(vote, selectedOption!, updatedList!);
  }
}
