

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';

var _separator = VxBox().height(1).color(Colors.grey[200]).make();

extension MenusExtension on Iterable<Menu> {

  Widget make({
    bool separated = false,
    Widget separator,
  }) {
    // ok this ok for title
    // what about grid
    return this.map((e) => e.make())
      .sperse(!separated ? null : separator ?? _separator)
      .filter((e) => e!=null).toList().vStack();
  }

  Menu group(Menu item, [MenuGroupViewType type = MenuGroupViewType.Page]) {
    item.items = this;
    item.groupType = type;
    return item;
  }

  Menu pageGroup(Menu item) {
    item.items = this;
    item.groupType = MenuGroupViewType.Page;
    return item;
  }

  Menu blockGroup(Menu item) {
    item.items = this;
    item.groupType = MenuGroupViewType.Block;
    return item;
  }
}

extension MenuExtension on Menu {

  Menu group(Iterable<Menu> items, [MenuGroupViewType type = MenuGroupViewType.Page]) {
    this.items = items;
    this.groupType = type;
    return this;
  }

  Menu pageGroup(Iterable<Menu> items) {
    this.items = items;
    this.groupType = MenuGroupViewType.Page;
    return this;
  }


  Menu blockGroup(Iterable<Menu> items) {
    this.items = items;
    this.groupType = MenuGroupViewType.Block;
    return this;
  }
}