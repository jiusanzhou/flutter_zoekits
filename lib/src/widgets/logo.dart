


import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:velocity_x/velocity_x.dart';

class ZLogo extends StatelessWidget {

    final Key key;
    final String src;
    final String title;
    final double size;
    final double round; 
    final Color background;
    // shadow

  const ZLogo({
    this.key,
    this.src,
    this.title,
    this.size = 80,
    this.round = 10,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return src != null
      ? src.image(size: size)
      : title != null
        ? Directionality(
          textDirection: TextDirection.ltr,
          child: "${title[0]}".text.bold.size(size / 2).white.make().centered()
            .box.size(size, size)
            .color(src != null ? null : background ?? Theme.of(context).primaryColor)
            .customRounded(BorderRadius.all(Radius.circular(round)))
            .make(),
          )
        : Container();
  }
}