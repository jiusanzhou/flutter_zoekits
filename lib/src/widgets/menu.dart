


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:velocity_x/velocity_x.dart';

enum MenuItemViewType {
  Grid,
  Tile,
  Block,
}

extension MenuItemViewTypeExt on MenuItemViewType {

  Widget build({
    MenuItemViewType type = MenuItemViewType.Tile,
    Key key,
    Widget title,
    Widget subtitle,
    Widget leading,
    Widget trailing,
    VoidCallback onTap,
    Color background,
  }) {
    final builders = <MenuItemViewType, Widget Function(
      Key key, Widget title, 
      Widget subtitle, Widget leading, Widget trailing,
      VoidCallback onTap,
      Color background,
    )>{

      MenuItemViewType.Grid: (key, title, subtitle, leading, trailing, onTap, background) => <Widget>[
        leading,
        title,
        subtitle,
        trailing,
      ].filter((e) => e!=null).toList().vStack(crossAlignment: CrossAxisAlignment.center)
        .box.color(background).make().onInkTap(onTap ?? () {}),
      
      MenuItemViewType.Tile: (key, title, subtitle, leading, trailing, onTap, background) => ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        minLeadingWidth: 20, // TODO:
      ).box.color(background).make(),

      // just use for block group
      MenuItemViewType.Block: (key, title, subtitle, leading, trailing, onTap, background) => [
        // title             trailing
        // leading  leading  leading
        // subtitle

        // title       
        // leading
        [title, trailing].filter((e) => e!=null).toList().hStack(
          axisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.spaceBetween,
        ).p8(),
        leading?.box?.color(background)?.make(),
        subtitle?.p8(),
      ].filter((e) => e!=null).toList()
        .vStack(crossAlignment: CrossAxisAlignment.start).box.margin(EdgeInsets.only(bottom: 20)).make()
    };

    return builders[this]?.call(
      key, title,
      subtitle, leading,
      trailing, onTap,
      background,
    );
  }

}

// action:
  // route => Route
  // to => String
  // href => https://
  // onTap => VoidCallback

// valuer:
  // bool => switcher
  // options<1, 2, ...> => checker
  // options<1> => selector <search>
  // string => input

// other classs need to build this
class MenuBasicItem extends StatelessWidget {
  final MenuItemViewType type;

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;

  final Route route;
  final String to;
  final String href;
  final VoidCallback onTap;
  final Function(BuildContext context) onTapWithContext;

  final Color primary;
  final Color background;

  const MenuBasicItem({
    Key key,
    this.type = MenuItemViewType.Tile,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.route, this.to, this.href, this.onTap, this.onTapWithContext,
    this.primary, this.background,
  }) : super(key: key);

  void _onTap(BuildContext context) {
    if (onTap != null) onTap();
    if (onTapWithContext != null) onTapWithContext(context);
    if (to != null) Navigator.of(context).pushNamed(to);
    if (route != null) Navigator.of(context).push(route);
    if (href != null) {}
    // TODO: use webview to open
  }

  @override
  Widget build(BuildContext context) {
    return type.build(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: () async => _onTap(context),
      background: background,
    );
  }
}

enum MenuGroupViewType {
  Block,
  Page,
}

extension MenuGroupViewTypeExt on MenuGroupViewType {

  // different itemViewType cause -->

  Widget build(Menu item, List<Menu> items) {

    final builders = <MenuGroupViewType, Widget Function(Menu item, List<Menu> items)> {
      MenuGroupViewType.Block: (Menu item, List<Menu> items) => 
        item.withType(MenuItemViewType.Block)
          .withLeading(items.make(separated: item.separated, separator: item.separator))
          .make(),

      MenuGroupViewType.Page: (Menu item, List<Menu> items) =>
        item.withExpended(true)
          .withOnTapWithContext(
            (context) => 
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => items.make(
                      separated: item.separated, separator: item.separator,
                    ).page(title: item.title))))
          .make(),
    };

    return builders[this]?.call(item, items);
  }

}

class MenuGroupView extends StatelessWidget {

  final MenuGroupViewType type;

  final Menu item;
  final List<Menu> items;

  const MenuGroupView({
    Key key,
    this.type = MenuGroupViewType.Page,
    // this.itemType,

    this.item,
    this.items,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type.build(item, items);
  }
}