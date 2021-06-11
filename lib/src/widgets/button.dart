

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

enum ButtonType {
  Elevated,
  Outlined,
  Simple,
  Text,
  // None, TODO: todo
}

typedef ButtonCreator = Widget Function({
  Key key,
  Widget child,
  VoidCallback onPressed,
  VoidCallback onLongPress,
  ButtonStyle style,
  FocusNode focusNode,
  bool autofocus,
  Clip clipBehavior,
});

typedef ButtonStyleCreator = ButtonStyle Function({
  Color primary, bool rounded,
});

final _btnFactories = <ButtonType, ButtonCreator>{
  ButtonType.Elevated: ({Key key, Widget child, VoidCallback onPressed, VoidCallback onLongPress, ButtonStyle style, FocusNode focusNode, bool autofocus, Clip clipBehavior}) => 
    ElevatedButton(key: key, onPressed: onPressed, child: child, onLongPress: onLongPress,
      style: style, focusNode: focusNode, autofocus: autofocus, clipBehavior: clipBehavior),

  ButtonType.Outlined: ({Key key, Widget child, VoidCallback onPressed, VoidCallback onLongPress, ButtonStyle style, FocusNode focusNode, bool autofocus, Clip clipBehavior}) => 
    OutlinedButton(key: key, onPressed: onPressed, child: child, onLongPress: onLongPress,
      style: style, focusNode: focusNode, autofocus: autofocus, clipBehavior: clipBehavior),

  ButtonType.Simple: ({Key key, Widget child, VoidCallback onPressed, VoidCallback onLongPress, ButtonStyle style, FocusNode focusNode, bool autofocus, Clip clipBehavior}) => 
    TextButton(key: key, onPressed: onPressed, child: child, onLongPress: onLongPress,
      style: style, focusNode: focusNode, autofocus: autofocus, clipBehavior: clipBehavior),

  ButtonType.Text: ({Key key, Widget child, VoidCallback onPressed, VoidCallback onLongPress, ButtonStyle style, FocusNode focusNode, bool autofocus, Clip clipBehavior}) => 
    TextButton(key: key, onPressed: onPressed, child: child, onLongPress: onLongPress,
      style: style, focusNode: focusNode, autofocus: autofocus, clipBehavior: clipBehavior),
};

final _btnStyleFactories = <ButtonType, ButtonStyleCreator>{
  ButtonType.Elevated: ({Color primary, bool rounded}) => 
    ElevatedButton.styleFrom(primary: primary, shape: rounded ? StadiumBorder() : null),
  ButtonType.Outlined: ({Color primary, bool rounded}) => 
    OutlinedButton.styleFrom(primary: primary, shape: rounded ? StadiumBorder() : null),
  ButtonType.Simple: ({Color primary, bool rounded}) => 
    TextButton.styleFrom(primary: primary, shape: rounded ? StadiumBorder() : null)
      .copyWith(backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        return states.contains(MaterialState.disabled)
          ? Colors.grey[100]
          : (primary??Colors.blue).withOpacity(0.12);
      })),
  ButtonType.Text: ({Color primary, bool rounded}) => 
    TextButton.styleFrom(primary: primary, shape: rounded ? StadiumBorder() : null),
};

class ZButton extends StatelessWidget {

  final Key key;

  final IconData icon;

  final Widget child;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  final ButtonStyle style;
  final FocusNode focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  final Color primary;
  final ButtonType type;

  final Widget busyChild;

  final bool rounded;
  final bool busying;
  final bool disabled;

  // CircularProgressIndicator, CupertinoActivityIndicator
  static const defaultBusyChild = CupertinoActivityIndicator(radius: 8);

  ZButton({
    this.key,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,

    this.icon, // TODO:  
    this.type = ButtonType.Simple,
    this.busyChild = defaultBusyChild,
    this.primary,
    this.rounded = true,
    this.busying = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {

    var _style = _btnStyleFactories[type].call(
      primary: primary ?? Theme.of(context).primaryColor, rounded: rounded);

    _style = _style.merge(style);

    // TODO: handle the icon

    VoidCallback _onPressed = disabled ? null : busying ? () => {} : onPressed;
    VoidCallback _onLongPress = disabled ? null : busying ? () => {} : onLongPress;

    Widget _child = !busying ? child : busyChild;

    return _btnFactories[type]?.call(
      key: key,
      onPressed: _onPressed,
      child: _child,
      onLongPress: _onLongPress,
      style: _style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
    );
  }
}