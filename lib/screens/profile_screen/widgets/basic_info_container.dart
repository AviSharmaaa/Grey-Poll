import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/size_config.dart';
import '../../../models/user_model.dart';
import '../../../utils/app_theme.dart';

class BasicInfoContainer extends StatelessWidget {
  BasicInfoContainer({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;
  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    String username = user.name!.substring(0, 1);
    return Column(
      children: [
        ClayContainer(
          width: S.width(120),
          height: S.height(120),
          surfaceColor: theme.kPrimaryColor,
          parentColor: theme.kCanvasColor,
          borderRadius: 200,
          depth: 50,
          curveType: CurveType.convex,
          child: Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: theme.kPrimaryColor,
              child: Text(
                username,
                style: TextStyle(
                  fontSize: 90,
                  color: theme.kWhiteText,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: S.all(12),
          child: Column(
            children: [
              Text(
                user.name!,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                user.email!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: theme.kSecondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
