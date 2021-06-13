


import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget mustWidget(dynamic e) {
  if (e == null) return null;
  return e is Widget ? e : "$e".text.make();
}