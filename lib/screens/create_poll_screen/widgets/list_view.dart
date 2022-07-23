import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

Widget listView(
  List<TextField> textFields,
  TextEditingController title,
  TextEditingController description,
) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: textFields.length + 2,
    itemBuilder: (context, index) {
      if (index == 0) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
            bottom: 5,
            right: 15,
          ),
          child: ClayContainer(
            borderRadius: 30,
            surfaceColor: Colors.white,
            depth: 30,
            child: TextField(
              controller: title,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.title_sharp,
                ),
                hintText: 'Title',
              ),
            ),
          ),
        );
      } else if (index == 1) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: ClayContainer(
            borderRadius: 30,
            surfaceColor: Colors.white,
            depth: 30,
            spread: 6,
            child: TextField(
              controller: description,
              maxLines: 3,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                label: Text('Description'),
              ),
            ),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ClayContainer(
          borderRadius: 30,
          surfaceColor: Colors.white,
          depth: 30,
          spread: 6,
          child: textFields[index - 2],
        ),
      );
    },
  );
}
