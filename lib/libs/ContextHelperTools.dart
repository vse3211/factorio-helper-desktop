import 'package:flutter/material.dart';

class ContextHelperTools { // cHT.    final ContextHelperTools cHT = ContextHelperTools(context, developerSize);
  final BuildContext context;
  final Size developerSize;
  late Size windowSize;
  ContextHelperTools(this.context, this.developerSize) {
    windowSize = MediaQuery.of(context).size;
  }

  double getLowerSize(Size size) =>
      size.width > size.height ? size.height : size.width;
  double getBiggerSize(Size size) =>
      size.width > size.height ? size.width : size.height;
  double getScaledWidth(double width) =>
      (width / developerSize.width) * windowSize.width;
  double getScaledHeight(double height) =>
      (height / developerSize.height) * windowSize.height;
  double getScaledBox(double size) =>
      (size / getLowerSize(developerSize)) * getLowerSize(windowSize);
  Size getScaledSize(Size size) => Size(getScaledWidth(size.width), getScaledHeight(size.height));
}