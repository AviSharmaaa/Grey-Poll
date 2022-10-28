import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class S {
  static double _screenWidth = 0;
  static double _screenHeight = 0;

  static double heightMultiplier = 0;
  static double widthMultiplier = 0;

  static double xFactor = 1.0;
  static double yFactor = 1.0;

  static double baseWidth = 375;
  static double baseHeight = 812;

  void init(BoxConstraints constraints) {
    var height = 812.00;
    var width = 375.00;

    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    heightMultiplier = _screenHeight / height;
    widthMultiplier = _screenWidth / width;

    yFactor = _screenHeight / height;
    xFactor = _screenWidth / width;
  }

  static double? height(value) => yFactor * value;

  static double? width(value) => xFactor * value;

  static double? percentHeight(value) => value * baseHeight * xFactor;

  static double? percentWidth(value) => value * baseWidth * xFactor;

  static EdgeInsets only({
    left = 0.0,
    top = 0.0,
    right = 0.0,
    bottom = 0.0,
  }) =>
      EdgeInsets.only(
          left: left * xFactor,
          right: right * xFactor,
          top: top * yFactor,
          bottom: bottom * yFactor);

  static EdgeInsets symmetric({
    horizontal = 0.0,
    vertical = 0.0,
  }) =>
      EdgeInsets.symmetric(
        horizontal: horizontal * xFactor,
        vertical: vertical * yFactor,
      );

  static EdgeInsets all(value) => EdgeInsets.symmetric(
        horizontal: value * xFactor,
        vertical: value * yFactor,
      );
}
