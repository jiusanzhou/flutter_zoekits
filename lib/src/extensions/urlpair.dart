

import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:velocity_x/velocity_x.dart';

extension LabelURLBuilder on LabelURL {

  Widget make({
    double size = 12,
    Color color,
    Function (LabelURL pair) onTap,
  }) {
    return "${this.label}".text.color(color).size(size).make().onTap(() => onTap?.call(this));
  }

}