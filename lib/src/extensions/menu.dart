

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';

var _separator = VxBox().height(1).color(Colors.grey[200]).px16.make();

extension MenusExtension on Iterable<Menu> {

  Widget make({
    bool separated = false,
    Widget separator,
    bool grided = false,
    int gridCrossAxisCount = 3,
    double gridHeight = 120,
    double gridChildAspectRatio = 1,
  }) {
    // ok this ok for title
    // what about grid
    return grided
      ? GridView.count(
        crossAxisCount: gridCrossAxisCount,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: gridChildAspectRatio,
        children: this.map((e) => e.make()).toList(),
      ).box.height(gridHeight).make()
      : this.map((e) => e.make())
        .sperse(!separated ? null : separator ?? _separator)
        .filter((e) => e!=null).toList().vStack();
  }

  Menu group(Menu item, {
    MenuGroupViewType type = MenuGroupViewType.Page,
    bool separated = false,
    Widget separator,
    int gridCrossAxisCount = 3,
    double gridHeight = 120,
    double gridChildAspectRatio = 1,
  }) {
    item.items = this;
    item.groupType = type;
    item.separated = separated;
    item.separator = separator;
    item.gridCrossAxisCount = gridCrossAxisCount;
    item.gridHeight = gridHeight;
    item.gridChildAspectRatio = gridChildAspectRatio;
    return item;
  }

  Menu pageGroup(Menu item, {
    bool separated = false,
    Widget separator,
    int gridCrossAxisCount = 3,
    double gridHeight = 120,
    double gridChildAspectRatio = 1,
  }) {
    item.items = this;
    item.groupType = MenuGroupViewType.Page;
    item.separated = separated;
    item.separator = separator;
    item.gridCrossAxisCount = gridCrossAxisCount;
    item.gridHeight = gridHeight;
    item.gridChildAspectRatio = gridChildAspectRatio;
    return item;
  }

  Menu blockGroup(Menu item, {
    bool separated = false,
    Widget separator,
    int gridCrossAxisCount = 3,
    double gridHeight = 120,
    double gridChildAspectRatio = 1,
  }) {
    item.items = this;
    item.groupType = MenuGroupViewType.Block;
    item.separated = separated;
    item.separator = separator;
    item.gridCrossAxisCount = gridCrossAxisCount;
    item.gridHeight = gridHeight;
    item.gridChildAspectRatio = gridChildAspectRatio;
    return item;
  }
}

extension MenuExtension on Menu {

  Menu group(Iterable<Menu> items, {
    MenuGroupViewType type = MenuGroupViewType.Page,
    bool separated = false,
    Widget separator,
    int gridCrossAxisCount = 3,
    double gridHeight = 120,
    double gridChildAspectRatio = 1,
  }) {
    this.items = items;
    this.groupType = type;
    this.separated = separated;
    this.separator = separator;
    this.grided = grided;
    this.gridCrossAxisCount = gridCrossAxisCount;
    this.gridHeight = gridHeight;
    this.gridChildAspectRatio = gridChildAspectRatio;
    return this;
  }

  Menu pageGroup(Iterable<Menu> items, {
    bool separated = false,
    Widget separator,
    int gridCrossAxisCount = 3,
    double gridHeight = 120,
    double gridChildAspectRatio = 1,
  }) {
    this.items = items;
    this.groupType = MenuGroupViewType.Page;
    this.separated = separated;
    this.separator = separator;
    this.gridCrossAxisCount = gridCrossAxisCount;
    this.gridHeight = gridHeight;
    this.gridChildAspectRatio = gridChildAspectRatio;
    return this;
  }


  Menu blockGroup(Iterable<Menu> items, {
    bool separated = false,
    Widget separator,
    int gridCrossAxisCount = 3,
    double gridHeight = 120,
    double gridChildAspectRatio = 1,
  }) {
    this.items = items;
    this.groupType = MenuGroupViewType.Block;
    this.separated = separated;
    this.separator = separator;
    this.gridCrossAxisCount = gridCrossAxisCount;
    this.gridHeight = gridHeight;
    this.gridChildAspectRatio = gridChildAspectRatio;
    return this;
  }
}