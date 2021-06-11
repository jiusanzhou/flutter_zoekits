

import 'package:flutter/material.dart';
import 'package:flutter_zoekits/src/utils/image.dart';

extension ZImage on String {

  Widget image({double size = 80, double width, double height, BoxFit fit}) {
    return Image(
      width: width ?? size,
      height: height ?? size,
      fit: fit ?? BoxFit.cover,
      image: imageFromString(this),
    );
  }

}