

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:flutter_zoekits/src/widgets/webview.dart';
// import 'package:flutter_zoekits/src/models/urlpair.dart';
// import 'package:flutter_zoekits/src/utils/intersperse.dart';
// import 'package:flutter_zoekits/src/widgets/logo.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutView extends StatelessWidget {

  final String logo;
  final String title;
  final String description;
  final String version;
  final String copyright;
  final Widget child;

  final List<LabelURL> links;

  const AboutView({
    Key key,
    this.logo,
    this.title,
    this.description,
    this.version,
    this.copyright,
    this.child,
    this.links = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      SizedBox(height: 35),

      // logo
      ZLogo(src: logo).box.make().py8(),

      // title
      title != null ? "$title".text.bold.size(24).make().py4() : Container(),

      // description
      description != null ? "$description".text.make().py4() : Container(),

      // version<update notifaction>
      FutureBuilder<String>(
        future: version != null ? Future.value(version) : PlatformUtils.getAppVersion(),
        builder: (context, snapshot) => "v${snapshot.data}".text.gray500.make().py2(),
      ),

      // child.expand
      VxBox(child: child != null ? child : Container()).make().expand(),

      // copyright
      description != null ? "$copyright".text.gray500.size(8).make() : Container(),

      // links
      links.map((e) => "${e.label}".text.gray500.size(8).underline.make().onTap(() {
          Navigator.of(context).push(
            // CupertinoPageRoute
            MaterialPageRoute(
              builder: (context) => ZWebviewPage(url: e.url, title: e.label, replaceTitle: false),
            ),
          );
      }).box.make()).sperse("•".text.gray500.size(8).make().px4()).toList().hStack().py8(),
    ].vStack().p8();
  }
}