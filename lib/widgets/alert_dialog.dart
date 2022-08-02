import 'package:flutter/material.dart';

Widget customAlertDialog(BuildContext context, String title, String message,
    bool doesDisablePoll, Widget screen) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.pop(context, false);
        },
      ),
      TextButton(
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () {
          (doesDisablePoll == true)
              ? Navigator.pop(context, true)
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => screen,
                  ),
                );
        },
      )
    ],
  );
}
