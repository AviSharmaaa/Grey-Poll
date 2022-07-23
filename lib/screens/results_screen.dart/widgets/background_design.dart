import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';

class BackgroundDesign extends StatelessWidget {
  final AppTheme theme = AppTheme();
  BackgroundDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          color: theme.kCanvasColor,
          height: size.height * 0.4,
          child: Stack(
            children: [
              Positioned(
                right: -size.width * 0.2,
                top: -size.height * 0.1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 220,
                      height: 220,
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 180,
                      height: 180,
                      borderRadius: 200,
                      depth: 50,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 140,
                      height: 140,
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 100,
                      height: 100,
                      borderRadius: 200,
                      depth: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.4,
          child: Stack(
            children: [
              Positioned(
                left: -size.width * 0.18,
                bottom: size.height * 0.03,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kSecondaryColor,
                      width: 160,
                      height: 160,
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kSecondaryColor,
                      width: 140,
                      height: 140,
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kSecondaryColor,
                      width: 70,
                      height: 70,
                      borderRadius: 200,
                      depth: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.45,
          child: Stack(
            children: [
              Positioned(
                left: size.width * 0.55,
                bottom: 10,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kSecondaryColor2,
                      width: 100,
                      height: 100,
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kSecondaryColor2,
                      width: 80,
                      height: 80,
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
