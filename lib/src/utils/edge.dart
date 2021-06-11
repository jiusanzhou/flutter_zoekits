
import 'package:flutter/material.dart';

BorderRadiusGeometry borderRadiusFromArray(List<double> radiusArray) {
  assert(radiusArray == null
    || radiusArray.length == 0
    || radiusArray.length == 1
    || radiusArray.length == 4);

  if (radiusArray == null) return null;

  switch (radiusArray.length) {
    case 0:
      return null;
    case 1:
      return BorderRadius.all(Radius.circular(radiusArray[0]));
    case 4:
      return BorderRadius.only(
        topLeft: Radius.circular(radiusArray[0]),
        topRight: Radius.circular(radiusArray[1]),
        bottomRight: Radius.circular(radiusArray[2]),
        bottomLeft: Radius.circular(radiusArray[3]),
      );
    default:
      return null;
  }
}