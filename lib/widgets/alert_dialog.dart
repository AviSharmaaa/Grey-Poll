import 'package:flutter/material.dart';
import '../screens/result_screen.dart';


showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget continueButton = TextButton(
    child: const Text(
      "See Results",
      style: TextStyle(color: Colors.blue),
    ),
    onPressed: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ResultScreen()));
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("See Results"),
    content: const Text(
        "You have already participated in this poll. Would you like to see the results instead?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
