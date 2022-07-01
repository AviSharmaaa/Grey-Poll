import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';

class ChooseAvatar extends StatelessWidget {
  const ChooseAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  width: 5,
                  color: AppTheme().getPrimaryColor),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.person,
              color: Colors.grey.shade300,
              size: 80.0,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.fromLTRB(80, 80, 0, 0),
            child: Icon(
              Icons.add_circle,
              color: AppTheme().getPrimaryColor,
              size: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
