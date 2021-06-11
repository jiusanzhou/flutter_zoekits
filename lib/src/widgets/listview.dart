
import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:velocity_x/velocity_x.dart';
import './skeleton.dart';

// 基本列表
// 分类
// 筛选

class ListPage extends StatefulWidget {

  final Widget title;
  final Widget Function(BuildContext context, dynamic item, int index) itemRender;
  final Widget loadMore;
  final Widget refresh;

  final IndexedWidgetBuilder separatorBuilder;
  final Widget nonIdea;
  final Widget separator;

  final Future<List<dynamic>> Function() loadMoreFn;
  final Future<List<dynamic>> Function() refreshFn;

  ListPage({
    this.title,
    @required this.itemRender,
    this.loadMoreFn,
    this.loadMore,
    this.separatorBuilder,
    this.nonIdea,
    this.separator,
    this.refresh,
    this.refreshFn,
  });

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: widget.loadMoreFn!=null?ListViewAsync(
        loadMoreFn: widget.loadMoreFn,
        loadMore: widget.loadMore,
        refresh: widget.refresh,
        refreshFn: widget.refreshFn,

        itemRender: widget.itemRender,
        separatorBuilder: widget.separatorBuilder,
        nonIdea: widget.nonIdea,
        separator: widget.separator,
      ):ListViewBasic(
        itemRender: widget.itemRender,
        separatorBuilder: widget.separatorBuilder,
        nonIdea: widget.nonIdea,
        separator: widget.separator,
      ),
    );
  }
}

// 基础列表试图
class ListViewBasic extends StatefulWidget {

  final List<dynamic> items;

  final Widget Function(BuildContext context, dynamic item, int index) itemRender;

  final IndexedWidgetBuilder separatorBuilder;

  final Widget nonIdea;

  final Widget separator;

  final Widget footer; // after the last one

  final Function refresh;

  ListViewBasic({
    this.items,
    @required this.itemRender,
    this.separatorBuilder,
    this.separator,
    this.nonIdea,
    this.footer,
    this.refresh,
  });

  @override
  _ListViewBasicState createState() => _ListViewBasicState();
}

class _ListViewBasicState extends State<ListViewBasic> {

  var _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // if items is empty or length == 0, return nonIdea

    if (widget.items == null || widget.items.length == 0)
      // no idea builder
      return widget.nonIdea ?? _defualtNoIdea(context, refresh: widget.refresh);

    // builde separator
    if (widget.separatorBuilder != null || widget.separator != null)
      return ListView.separated(
        itemCount: _count,
        itemBuilder: _itemBuilder,
        separatorBuilder: _separatorBuilder,
      );

    // return a list builder
    return ListView.builder(
      // controller: _scrollController,
      itemCount: _count,
      itemBuilder: _itemBuilder,
    );

    // what about load more
  }

  int get _count => widget.items.length + ( widget.footer == null ? 0 : 1 );

  Widget _separatorBuilder(BuildContext context, int index) {
    return widget.separatorBuilder!=null?widget.separatorBuilder(context, index):widget.separator;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if ( index ==  widget.items.length ) return widget.footer;
    return widget.itemRender(context, widget.items[index], index);
  }

  Widget _defualtNoIdea(BuildContext context, {Function refresh}) {
    return [
      "💡".text.size(48).make(),
      "No data ~".text.gray900.make(),
      refresh != null
        ? ZButton(child: "Refresh".text.make(), onPressed: refresh)
        : Container(),
    ].vStack(
      alignment: MainAxisAlignment.center,
      axisSize: MainAxisSize.min,
    ).centered();
  }
}


// with auto load more
class ListViewAsync extends StatefulWidget {

  final List<dynamic> items;
  final Widget loadMore;
  final bool Function() hasMore;
  final Widget refresh;

  final Widget Function(BuildContext context, dynamic item, int index) itemRender;

  final IndexedWidgetBuilder separatorBuilder;
  final Widget nonIdea;
  final Widget separator;

  final Future<List<dynamic>> Function() loadMoreFn;
  final Future<List<dynamic>> Function() refreshFn;
  final Function() onLoadMore;

  ListViewAsync({
    this.refresh,
    this.hasMore,
    this.items,
    this.refreshFn,
    this.loadMore, // load more widget
    this.loadMoreFn,
    this.onLoadMore,
    @required this.itemRender,
    this.separatorBuilder,
    this.separator,
    this.nonIdea,
  });

  @override
  _ListViewAsyncState createState() => _ListViewAsyncState();
}

class _ListViewAsyncState extends State<ListViewAsync> {

  // List<dynamic> _items = [];

  Widget _skeleton = DefaultSkeletonItem();

  bool _firstTime = true;

  bool get _fullSkeleton => _firstTime && _loading;

  @override
  void initState() {
    super.initState();

    // load more once time
    // maybe load more is just a trigger
    _loadMore().whenComplete(() => _firstTime = false);
    // _items.addAll(widget.items??[]); // add from widget
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: NotificationListener(
        onNotification: _onNotification,
        child: !_fullSkeleton?ListViewBasic(
          items: widget.items,
          itemRender: widget.itemRender,
          separator: widget.separator,
          separatorBuilder: widget.separatorBuilder,
          nonIdea: widget.nonIdea,
          footer: _footer(),
          refresh: _loadMore,
        ):SkeletonList(builder: (context, index) => _skeleton),
      ),
      onRefresh: _onRefresh,
    );
  }

  Future<void> _onRefresh() {
    
  }

  Widget _footer() {
    // loading, load failed. TODO: if we load failed we need to display the error message.
    if (!widget.hasMore()) return Align(alignment: Alignment.center, child: Container(padding: EdgeInsets.all(10), child: "End~".text.make()));
    if (!_loading && _error != null) return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Text("ERROR: $_error"), InkWell(child: Text("Click to retry"), onTap: () => _loadMore())],
      ),
    );
    return _skeleton;
  }

  dynamic _error;
  bool _loading = false;

  Future<Null> _loadMore() async{
    if (!widget.hasMore()) return Future.value(null);
    setState(() => _loading = true);

    // loadMore just a trigger
    await widget.onLoadMore?.call();

    var e = widget.loadMoreFn == null
      ? Future.value(null)
      : widget.loadMoreFn.call().then((items) {
        setState(() => widget.items.addAll(items));
      }).catchError((e) {
        setState(() => _error = e);
      }).whenComplete(() => setState(() => _loading = false));
    
    setState(() => _loading = false);

    return e;
  }

  bool _loadMoreBusy = false;
  bool _onNotification(ScrollNotification note) {
    if (note.metrics.pixels != note.metrics.maxScrollExtent || _loadMoreBusy) return true;
    // 滑动到达底部
    _loadMoreBusy = true;
    _loadMore().whenComplete(() => _loadMoreBusy = false);
    return true;
  }
}















class DefaultSkeletonItem extends StatelessWidget {
  final int index;

  DefaultSkeletonItem({this.index: 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context,
                  width: 0.7, color: Colors.redAccent))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 100,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 30,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.7,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.8,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.5,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          // SizedBox(height: 10),
          // Row(
          //   children: <Widget>[
          //     Container(
          //       margin: EdgeInsets.only(right: 10),
          //       height: 8,
          //       width: 20,
          //       decoration: SkeletonDecoration(isDark: isDark),
          //     ),
          //     Container(
          //       height: 8,
          //       width: 80,
          //       decoration: SkeletonDecoration(isDark: isDark),
          //     ),
          //     Expanded(child: SizedBox.shrink()),
          //     Container(
          //       height: 20,
          //       width: 20,
          //       decoration: SkeletonDecoration(isDark: isDark),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
