import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:online_voting_app/utils/app_theme.dart';

class BackgroundDesign extends StatelessWidget {
  BackgroundDesign({Key? key}) : super(key: key);

  final AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          color: theme.kCanvasColor,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: -size.height * 0.05,
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
                left: -size.width * 0.05,
                bottom: size.height * 0.1,
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
          height: size.height * 0.43,
          child: Stack(
            children: [
              Positioned(
                left: size.width * 0.62,
                bottom: 0,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Stack(
            children: [
              Positioned(
                left: size.width * 0.03,
                bottom: 45,
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
