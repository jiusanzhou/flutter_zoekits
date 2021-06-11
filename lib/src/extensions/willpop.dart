
import 'package:flutter/material.dart';

const _defaultGapDuration = Duration(milliseconds: 1500);

extension PopScope on Widget {

  Widget willPop({
    Duration gapDuration = _defaultGapDuration,
    VoidCallback onPop,
  }) {
    DateTime _lastTime;
    return WillPopScope(
      child: this,
      onWillPop: () {
        if (_lastTime == null || DateTime.now().difference(_lastTime) > gapDuration) {
          // TODO: use value from onPop
          onPop?.call();
          _lastTime = DateTime.now();
          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}
