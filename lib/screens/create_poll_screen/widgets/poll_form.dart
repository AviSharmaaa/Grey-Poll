import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../state/current_user_state.dart';
import '../../../models/user_model.dart';
import '../../../state/misc_state.dart';
import '../../../state/poll_state.dart';
import '../../../utils/app_theme.dart';
import '../../../widgets/snack_bar.dart';
import 'list_view.dart';
import 'option_tile.dart';

class PollForm extends StatefulWidget {
  const PollForm({Key? key}) : super(key: key);

  @override
  State<PollForm> createState() => _PollFormState();
}

class _PollFormState extends State<PollForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<TextEditingController> _controllers =
      PollState().getTextEditingController;

  final List<TextField> _textFields = PollState().getTextField;

  int buttonDepth = -40;
  final AppTheme theme = AppTheme();

  void validateAndSubmit() async {
    MiscState miscProvider = Provider.of<MiscState>(context, listen: false);
    PollState pollProvider = Provider.of<PollState>(context, listen: false);

    if (isValidPollFormat()) {
      String response = await _createNewPoll(
        _titleController,
        _descriptionController,
        _controllers,
      );

      if (response == 'success') {
        pollProvider.loadPollList();
        miscProvider.setCurrentIndex = 0;
      }
    } else {
      showSnackBar(context, 'At least 2 options are required');
    }
  }

  Future<String> _createNewPoll(
    TextEditingController title,
    TextEditingController description,
    List<TextEditingController> options,
  ) async {
    UserModel user = Provider.of<CurrentUser>(
      context,
      listen: false,
    ).getCurrentUser;

    String? userId = user.uid;
    List<String>? updatedList = user.pollsCreated;
    Uuid uuid = const Uuid();
    String pollId = uuid.v4();
    Map<String, dynamic> optionsList = <String, dynamic>{};
    String pollTitle = title.text;
    String pollDescription = description.text;
    String response = 'error';

    updatedList?.add(pollId);

    if (_titleController.text.length >= 6) {
      for (TextEditingController element in options) {
        if (element.text.isNotEmpty) {
          optionsList[element.text] = 0;
        }
      }

      if (optionsList.length < 2) {
        showSnackBar(context, 'Poll must contain at least 2 options');
        response = 'error';
      } else {
        response = await PollState().createPoll(
          pollId,
          pollTitle,
          pollDescription,
          optionsList,
          userId!,
        );
        response = await CurrentUser().updatePollsCreated(updatedList!);
      }
    } else {
      showSnackBar(
        context,
        'Title length must be greater than or equal to 6 characters.',
      );
      response = 'error';
    }
    return response;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool isValidPollFormat() {
    if (_controllers.length < 2) {
      return false;
    }
    return true;
  }

  Widget _submitButton() {
    return ClayAnimatedContainer(
      duration: const Duration(milliseconds: 300),
      surfaceColor: theme.kSecondaryColor,
      depth: -buttonDepth,
      borderRadius: 30,
      curveType: CurveType.concave,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
        child: GestureDetector(
          onTapDown: (val) {
            setState(() {
              buttonDepth = -buttonDepth;
            });
          },
          onTapUp: (val) {
            setState(() {
              buttonDepth = -buttonDepth;
            });
            validateAndSubmit();
          },
          child: Text(
            "Create Poll",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: theme.kWhiteText,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MiscState>(builder: (context, value, child) {
      return Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                optionTile(
                  context,
                  _controllers,
                  _textFields,
                  theme,
                ),
              ],
            ),
          ),
          listView(
            _textFields,
            _titleController,
            _descriptionController,
          ),
          const SizedBox(
            height: 30,
          ),
          _submitButton(),
          const SizedBox(
            height: 30,
          ),
        ],
      );
    });
  }
}
