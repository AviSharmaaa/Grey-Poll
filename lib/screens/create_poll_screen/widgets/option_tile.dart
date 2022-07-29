import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:provider/provider.dart';
import '../../../state/poll_state.dart';

Widget optionTile(
  BuildContext context,
  List<TextEditingController> controllers,
  List<TextField> textFields,
  AppTheme theme,
) {
  PollState provider = Provider.of<PollState>(
    context,
    listen: false,
  );
  return ClayContainer(
      height: 50,
      width: 115,
      borderRadius: 30,
      depth: 100,
      surfaceColor:
          (controllers.length < 4) ? theme.kSecondaryColor : Colors.white,
      child: InkWell(
        onTap: (controllers.length < 4)
            ? () {
                {
                  final controller = TextEditingController();
                  final field = TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lightbulb_circle_outlined),
                      hintText: 'Option ${controllers.length + 1}',
                    ),
                  );
                  controllers.add(controller);
                  textFields.add(field);
                  provider.setTextEditingControllers = controllers;
                  provider.setTextField = textFields;
                }
              }
            : null,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                (controllers.length < 4) ? Icons.add : Icons.cancel_outlined,
                size: 30,
                color: (controllers.length < 4) ? Colors.white : Colors.red,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'ADD',
                style: TextStyle(
                  decoration: (controllers.length < 4)
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: (controllers.length < 4) ? Colors.white : Colors.red,
                ),
              )
            ],
          ),
        ),
      ));
}
