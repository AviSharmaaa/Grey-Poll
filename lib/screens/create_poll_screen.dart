import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/current_user.dart';
import '../models/user_model.dart';
import '../state/vote_state.dart';
import '../utils/app_theme.dart';
import '../widgets/header.dart';
import '../widgets/snack_bar.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({Key? key}) : super(key: key);

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final TextEditingController _titleController = TextEditingController();

  final List<TextEditingController> _controllers =
      VoteState().getTextEditingController;

  final List<TextField> _textFields = VoteState().getTextField;

  void _createNewPoll(
      TextEditingController title, List<TextEditingController> options) async {
    UserModel user =
        Provider.of<CurrentUser>(context, listen: false).getCurrentUser;
    String? userId = user.uid;
    List<String>? updatedList = user.pollsCreated;
    Uuid uuid = const Uuid();
    String pollId = uuid.v4();
    Map<String, dynamic> optionsList = <String, dynamic>{};
    String pollTitle = title.text;

    updatedList?.add(pollId);

    if (_titleController.text.length >= 6) {
      for (TextEditingController element in options) {
        if (element.text.isNotEmpty) {
          optionsList[element.text] = 0;
        }
      }

      if (optionsList.length < 2) {
        showSnackBar(context, 'Poll must contain at least 2 options');
      } else {
        VoteState()
            .createPoll(context, pollId, pollTitle, optionsList, userId!);

        CurrentUser().updatePollsCreated(updatedList!);
      }
    } else {
      showSnackBar(context,
          'Title length must be greater than or equal to 6 characters.');
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget optionTile() {
    VoteState provider = Provider.of<VoteState>(context, listen: false);
    return SizedBox(
      height: 50,
      width: 115,
      child: TextButton.icon(
        onPressed: (_controllers.length < 4)
            ? () {
                {
                  final controller = TextEditingController();
                  final field = TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Option ${_controllers.length + 1}',
                    ),
                  );
                  _controllers.add(controller);
                  _textFields.add(field);
                  provider.setTextEditingControllers = _controllers;
                  provider.setTextField = _textFields;
                }
              }
            : null,
        style: TextButton.styleFrom(
          primary: AppTheme().getCanvasColor,
          backgroundColor: (_controllers.length < 4)
              ? AppTheme().getPrimaryColor
              : Colors.grey.shade400,
          onSurface: Colors.black,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        label: const Text('ADD'),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _textFields.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            child: _textFields[index],
          );
        });
  }

  bool isValidPollFormat() {
    if (_controllers.length < 2) {
      return false;
    }

    return true;
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 60,
        width: 180,
        child: TextButton(
          onPressed: () {
            if (isValidPollFormat()) {
              _createNewPoll(_titleController, _controllers);
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
            } else {
              showSnackBar(context, 'At least 2 options are required');
            }
          },
          style: TextButton.styleFrom(
            primary: AppTheme().getCanvasColor,
            backgroundColor: AppTheme().getPrimaryColor,
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
          child: const Text(
            "Create Poll",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VoteState>(builder: (context, provider, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 250,
              child: Header(250, true, Icons.poll_outlined),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  optionTile(),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20, left: 8, bottom: 5, right: 8),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
            ),
            _listView(),
            _submitButton(),
          ]),
        ),
      );
    });
  }
}
