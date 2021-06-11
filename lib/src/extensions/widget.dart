

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

extension dynamicWidget on dynamic {
  Widget get widget => "$this".text.make();
}

extension StringWidget on String {
  Widget get widget => "$this".text.make();
}

extension WidgetWidget on Widget {
  Widget get widget => this;
}