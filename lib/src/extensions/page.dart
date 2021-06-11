


import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:flutter_zoekits/src/utils/utils.dart';

enum PageType {
  Scaffold,
}

extension PageTypeBuilder on PageType {

  Widget build({
    String title,
    List<Widget> actions,
    Widget child,
    Color background,
  }) {

    final builders = <PageType, Widget Function(dynamic title, List<Widget>, Widget child)> {
      PageType.Scaffold: (title, actions, child) {
        return Scaffold(
          appBar: (title != "" || actions != null) ? AppBar(
            title: mustWidget(title),
            actions: actions,
            centerTitle: true,
          ) : null,
          body: child,
          backgroundColor: background,
        );
      },
    };

    return builders[this].call(title, actions, child);
  }

}

extension ZSimplePage on Widget {

  Widget page({
    PageType type = PageType.Scaffold,
    String title,
    List<Widget> actions,
  }) {
    return type.build(
      title: title,
      actions: actions,
      child: this,
    );
  }

}