import 'package:flutter/material.dart';


const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);


class ZSnackBar extends StatelessWidget {
  
  final Widget content;
  final String label;
  final VoidCallback onPress;
  final Duration duration;

  const ZSnackBar({
    Key key,
    @required this.content,
    this.label = "Undo",
    this.onPress,
    this.duration = _snackBarDisplayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      action: onPress != null ? SnackBarAction(
        label: label,
        onPressed: onPress,
        textColor: Colors.redAccent,
      ) : null,
      duration: duration,
    );
  }

  show(BuildContext context) {
    final Widget child = build(context);
    ScaffoldMessenger.of(context).showSnackBar(child);
  }
}