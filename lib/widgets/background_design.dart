import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';
import 'package:online_voting_app/utils/size_config.dart';

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
    return Stack(
      children: [
        SizedBox(
          height: (sizedboxOneHeight == null) ? S.percentHeight(1.0) : S.height(sizedboxOneHeight),
          child: Stack(
            children: [
              Positioned(
                right: S.width(shapeOneRight),
                top: S.percentHeight(-shapeOneTop),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(220),
                      height: S.height(220),
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(180),
                      height: S.height(180),
                      borderRadius: 200,
                      depth: 50,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(140),
                      height: S.height(140),
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(100),
                      height: S.height(100),
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
          height: (sizedboxTwoHeight == null) ? S.percentHeight(0.4) : S.height(sizedboxTwoHeight),
          child: Stack(
            children: [
              Positioned(
                left: S.percentWidth(-shapeTwoLeft),
                bottom: S.percentHeight(shapeTwoBottom),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(160),
                      height: S.height(160),
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(140),
                      height: S.height(140),
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(70),
                      height: S.height(70),
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
          height: (sizedboxThreeHeight == null) ? S.percentHeight(0.43) : S.height(sizedboxThreeHeight),
          child: Stack(
            children: [
              Positioned(
                left: S.percentWidth(shapeThreeLeft),
                bottom: S.height(shapeThreeBottom),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(100),
                      height: S.height(100),
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(80),
                      height: S.height(80),
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(60),
                      height: S.height(60),
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.concave,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(30),
                      height: S.height(30),
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
          height: (sizedboxFourHeight == null) ? S.percentHeight(1.0) : S.height(sizedboxFourHeight),
          child: Stack(
            children: [
              Positioned(
                left: S.percentWidth(shapeFourLeft),
                bottom: shapeFourBottom,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(80),
                      height: S.height(80),
                      borderRadius: 200,
                      depth: 50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(50),
                      height: S.height(50),
                      borderRadius: 200,
                      depth: -50,
                      curveType: CurveType.convex,
                    ),
                    ClayContainer(
                      color: theme.kPrimaryColor,
                      width: S.width(20),
                      height: S.height(20),
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
