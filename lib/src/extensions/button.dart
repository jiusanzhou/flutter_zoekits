import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';

extension zButton on Widget {

  Widget button({
    Key key,
    IconData icon,
    VoidCallback onPressed,
    VoidCallback onLongPress,
    ButtonStyle style,
    FocusNode focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    Color primary,
    ButtonType type = ButtonType.Simple,
    Widget busyChild = ZButton.defaultBusyChild,
    bool rounded,
    bool busying,
    bool disabled,
  }) {
    return ZButton(
      child: this,
      icon: icon,
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      clipBehavior: clipBehavior,
      primary: primary,
      type: type,
      busyChild: busyChild,
      rounded: rounded,
      busying: busying,
      disabled: disabled,
    );
  }

}