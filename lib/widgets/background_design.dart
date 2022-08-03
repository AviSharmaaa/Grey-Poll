import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';

class BackgroundDesign extends StatelessWidget {
  BackgroundDesign({
    Key? key,
    required this.shapeOneTop,
    required this.shapeOneRight,
    required this.shapeTwoLeft,
    required this.shapeTwoBottom,
    required this.shapeThreeLeft,
    required this.shapeThreeBottom,
    required this.shapeFourLeft,
    required this.shapeFourBottom,
    this.sizedboxOneHeight,
    this.sizedboxTwoHeight,
    this.sizedboxThreeHeight,
    this.sizedboxFourHeight,
  }) : super(key: key);

  final double shapeOneTop;
  final double shapeOneRight;
  final double shapeTwoLeft;
  final double shapeTwoBottom;
  final double shapeThreeLeft;
  final double shapeThreeBottom;
  final double shapeFourLeft;
  final double shapeFourBottom;
  final double? sizedboxOneHeight;
  final double? sizedboxTwoHeight;
  final double? sizedboxThreeHeight;
  final double? sizedboxFourHeight;

  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          height: (sizedboxOneHeight == null) ? size.height : sizedboxOneHeight,
          child: Stack(
            children: [
              Positioned(
                right: shapeOneRight,
                top: -size.height * shapeOneTop,
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
          height: (sizedboxTwoHeight == null) ? size.height * 0.4 : sizedboxTwoHeight,
          child: Stack(
            children: [
              Positioned(
                left: -size.width * shapeTwoLeft,
                bottom: size.height * shapeTwoBottom,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 160,
                      height: 160,
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
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
          height: (sizedboxThreeHeight == null) ? size.height * 0.43 : sizedboxThreeHeight,
          child: Stack(
            children: [
              Positioned(
                left: size.width * shapeThreeLeft,
                bottom: shapeThreeBottom,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 100,
                      height: 100,
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 80,
                      height: 80,
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 60,
                      height: 60,
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.concave,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 30,
                      height: 30,
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: (sizedboxFourHeight == null) ? size.height : sizedboxFourHeight,
          child: Stack(
            children: [
              Positioned(
                left: size.width * shapeFourLeft,
                bottom: shapeFourBottom,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 80,
                      height: 80,
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 50,
                      height: 50,
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: 20,
                      height: 20,
                      borderRadius: 200,
                      depth: 50,
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
