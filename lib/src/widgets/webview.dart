



import 'package:flutter/material.dart';
import 'package:flutter_zoewebview/flutter_zoewebview.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';

class ZWebviewPage extends StatefulWidget {

  final String url;
  final String title;
  final bool replaceTitle;

  const ZWebviewPage({
    Key key,
    this.url,
    this.title,
    this.replaceTitle = true,
  }) : super(key: key);

  @override
  _ZWebviewPageState createState() => _ZWebviewPageState();
}

class _ZWebviewPageState extends State<ZWebviewPage> {

  String _title;
  bool _loading = true;

  ZoeWebviewController _controller;

  Future<bool> _willPop() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _onWebViewCreated(c) {
    _controller = c;
  }

  _onLoadStart(_, __) {
    setState(() => _loading = true);
  }

  _onLoadStop(_, __) {
    _controller.getTitle().then((value) => setState(() => _title = value));
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _loading || !widget.replaceTitle
          ? widget.title ?? "加载中..."
          : _title,
        ),
        centerTitle: true,
      ),
      body: ZoeWebview(
        initialUrl: widget.url,
        onWebViewCreated: _onWebViewCreated,
        onLoadStart: _onLoadStart,
        onLoadStop: _onLoadStop,
      ).willPop(onWillPop: _willPop),
    );
  }
}