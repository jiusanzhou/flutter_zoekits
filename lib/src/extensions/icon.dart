
import 'package:flutter/material.dart';

extension ZIconButton on IconData {
  Widget onPress(VoidCallback onPressed) {
    return IconButton(onPressed: onPressed, icon: Icon(this));
  }
}