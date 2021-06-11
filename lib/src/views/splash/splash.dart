

// splash page
// is the first page when open app(after native splash page)
// try to init every things when page open
// and you can add something things in to slash page container
// like ads
// every launch will should open splash page

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashView extends StatefulWidget {

  // TODO: define configuration the splash page

  final Widget child;
  final WidgetBuilder builder;
  final Future<dynamic> Function(BuildContext context) initFunc;
  final List<Future<dynamic>> initItems;

  // TODO: add finish router?

  SplashView({
    @required this.child,
    @required this.builder,
    this.initFunc,
    this.initItems,
  }) : assert(child != null, builder != null);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  bool initializing = true;
  List<Error> errors = [];

  @override
  void initState() {
    super.initState();

    initStateAsync();
  }

  initStateAsync() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait(widget.initItems ?? []);
      await widget.initFunc?.call(context)?.catchError((e) => setState(() => errors.add(e)));

      setState(() {
        initializing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return initializing
      // ? MaterialApp(home: Scaffold(body: widget.builder(context)))
      ? widget.builder(context)
      : widget.child;
  }
}