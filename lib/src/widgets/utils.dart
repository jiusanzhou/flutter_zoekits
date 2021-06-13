

import 'package:flutter/material.dart';
import 'package:flutter_zoekits/src/widgets/input_field.dart';

Widget mustWidgetOrInputField(dynamic e, [InputFieldOptions opts]) {
  if (e == null) return null;
  return e is Widget ? e : InputField(value: e, opts: opts);
}