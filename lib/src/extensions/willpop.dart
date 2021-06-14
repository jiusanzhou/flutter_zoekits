
import 'package:flutter/material.dart';

const _defaultGapDuration = Duration(milliseconds: 1500);

extension PopScope on Widget {

  Widget willPop({
    Duration gapDuration = _defaultGapDuration,
    WillPopCallback onWillPop,
  }) {
    DateTime _lastTime;
    return WillPopScope(
      child: this,
      onWillPop: () async {
        // else use the gap duration
        if (_lastTime == null || DateTime.now().difference(_lastTime) > gapDuration) {
          _lastTime = DateTime.now();
          return onWillPop?.call() ?? Future.value(false);
        } else {
          return Future.value(true);
        }
      },
    );
  }
}
