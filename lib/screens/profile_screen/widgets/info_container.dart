import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import '../../../utils/app_theme.dart';

class InfoContainer extends StatelessWidget {
  final int count;
  final String title;
  final AppTheme theme = AppTheme();
  InfoContainer({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: S.width(160),
      padding: S.all(12),
      decoration: BoxDecoration(
        color: theme.kCanvasColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(7, 10),
          ),
        ],
      ),
      child: Column(children: [
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme.kSecondaryTextColor,
          ),
        ),
      ]),
    );
  }
}
