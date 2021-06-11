

import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:flutter_zoekits/src/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class Menu {

  dynamic title;
  dynamic description;
  dynamic value;

  Widget leading;
  Widget trailing;


  Iterable<Menu> items;

  Route route;
  String to;
  String href;
  VoidCallback onTap;
  Function(BuildContext context) onTapWithContext;

  IconData icon;
  Color primary;
  Color background;

  MenuItemViewType itemType;
  MenuGroupViewType groupType;

  bool expended;

  bool separated = false;
  Widget separator;

  // .group(items)

  Menu({
    this.icon, this.background, this.primary,
    this.title, this.description, this.value,
    this.leading, this.trailing,
    this.items,
    this.route, this.to, this.href, this.onTap, this.onTapWithContext,
    this.itemType = MenuItemViewType.Tile, this.groupType,
    this.expended = false,
    this.separated = false, this.separator,
  });

  bool get _needExpand => to != null || route != null || href != null || expended;

  Menu withOnTap(VoidCallback tap) {
    onTap = tap;
    return this;
  }

  Menu withOnTapWithContext(Function(BuildContext context) tap) {
    onTapWithContext = tap;
    return this;
  }

  Menu withExpended(bool v) {
    expended = v;
    return this;
  }

  Menu withType(MenuItemViewType x) {
    itemType = x;
    return this;
  }

  Menu withRoute(Route r) {
    route = r;
    return this;
  }

  Menu withTitle(dynamic x) {
    title = x;
    return this;
  }

  Menu withDescription(dynamic x) {
    description = x;
    return this;
  }

  Menu withLeading(Widget x) {
    leading = x;
    return this;
  }

  Menu withTrailing(Widget x) {
    trailing = x;
    return this;
  }

  Menu withBackground(Color x) {
    background = x;
    return this;
  }

  // only one method can be called
  Widget make() {
    if (items != null) items.map((e) => e.withBackground(background).withType(itemType));
  
    // is group or basic
    return items == null
      ? MenuBasicItem(
        type: itemType,
        leading: leading != null ? leading : icon != null ? Icon(icon, color: primary) : null,
        title: mustWidget(title),
        subtitle: mustWidget(description),
        trailing: trailing != null ? trailing : [
          value != null ? "$value".text.make() : null,
          _needExpand ? Icon(Icons.chevron_right) : null
        ].filter((e) => e!=null).toList().hStack(),
        to: to, route: route, href: href, onTap: onTap, onTapWithContext: onTapWithContext,
        primary: primary, background: background,
      )
      // if with items then with wrap the group
      : MenuGroupView(
          type: groupType,
          item: Menu(
            icon: icon, title: title,
            description: description, value: value,
            background: background, primary: primary,
            itemType: itemType,
          ), // use menu copy
          items: items,
      );
  }
}