import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_voting_app/utils/size_config.dart';

Column buildPage(
  BuildContext context,
  String imagePath,
  String title,
  String content,
  double topPadding,
) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: S.symmetric(
            horizontal: 20,
            vertical: 150,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                imagePath,
                height: S.percentHeight(0.45),
              ),
              Padding(
                padding: S.only(top: topPadding),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Padding(
                padding: S.symmetric(vertical: 10.0),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
