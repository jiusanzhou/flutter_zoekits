
import 'package:flutter/material.dart';
import 'package:flutter_zoekits/src/utils/color.dart';
import 'package:flutter_zoekits/src/utils/edge.dart';
import 'package:flutter_zoekits/src/utils/image.dart';

extension ZBackground on Widget {
  Widget withZBackground({
    String imageUrl,
    BoxFit imageFit,
    DecorationImage image,

    Color color,
    String colorStr,

    List<double> radiusArray,
    BorderRadiusGeometry radius,
  }) {

    DecorationImage _image;
    Color _color;
    BorderRadiusGeometry _radius;

    if (imageUrl != null && imageUrl != "") {
      _image = DecorationImage(
        fit: imageFit ?? BoxFit.fill,
        image: imageFromString(imageUrl),
      );
    }

    _color = colorFromString(colorStr);

    _radius = borderRadiusFromArray(radiusArray);

    if (image != null) _image = image;
    if (color != null) _color = color;
    if (radius != null) _radius = radius;

    return Container(
      decoration: BoxDecoration(
        color: _color,
        image: _image,
        borderRadius: _radius,
      ),
      child: this,
    );
  }

}