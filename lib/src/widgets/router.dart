

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RouteType {
  Cupertino,
  Material,
}

extension RouteTypeMethod on RouteType {

  PageRoute build(
    WidgetBuilder builder,
    String name,
    String title, Object args,
  ) {

    final factories = <RouteType, PageRoute Function(
      WidgetBuilder builder,
      String title,
      RouteSettings setting,
    )>{
      RouteType.Cupertino: (builder, title, setting) => CupertinoPageRoute(
          builder: builder,
          title: title, settings: setting,
        ),
      RouteType.Material: (builder, title, setting) => MaterialPageRoute(
        builder: builder, settings: setting,
      ),
    };

    final createInstance = factories[this];

    RouteSettings setting;

    if (name != null || args != null) setting = RouteSettings(name: name, arguments: args);

    return createInstance?.call(builder, title, setting);
  }
}

class ZRouter {

  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  final RouteType type;

  final String name;
  final String title;
  final Object arguments;

  ZRouter(this.builder, {
    this.type = RouteType.Cupertino,
    this.name,
    this.title,
    this.arguments,
  });

  PageRoute build(Object args) {
    return type.build(builder, name, title, args ?? arguments);
  }
}

RouteFactory buildRouteGenerater(Map<String, ZRouter> routes) {
  return (RouteSettings settings) {
    final router = routes[settings.name];
    return router?.build(settings.arguments);
  };
}