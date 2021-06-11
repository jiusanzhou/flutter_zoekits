
import 'package:flutter/material.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:velocity_x/velocity_x.dart';

class ZBottomSheet extends StatelessWidget {

  final Widget child;
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final List<Widget> actions;
  final bool Function() onCancel;
  final Widget cancel;
  final double borderRadius;
  final bool isDismissible;
  // final double height;

  PersistentBottomSheetController<T> show<T>(BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: build,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius),),
      ),
    );
  }

  Future<T> showModal<T>(BuildContext context) {
    return showModalBottomSheet(
      context: context, builder: build,
      isScrollControlled: true,
      isDismissible: isDismissible == null ? !needCancel : isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius),),
      ),
    );
  }

  ZBottomSheet(this.child, {
    this.title, this.leading, this.trailing, this.actions,
    this.borderRadius = 10,
    this.onCancel, this.cancel,
    this.isDismissible,
  });

  // leading title tailing
  // actions

  @override
  Widget build(BuildContext context) {
    return [
      [
        // [
        //   (leading ?? Container()).expand(flex: 3),
        //   VxBox().width(45).height(6).rounded.color(Color.fromARGB(255, 230, 236, 240)).make(),
        //   (trailing ?? Container()).box.make().expand(flex: 3),
        // ].hStack(
        //   alignment: MainAxisAlignment.spaceBetween,
        //   axisSize: MainAxisSize.max
        // ).box.p12.make(),
        // title ?? Container(),
        VxBox().width(45).height(6).rounded.color(Color.fromARGB(255, 230, 236, 240)).margin(Vx.mOnly(top: 10, bottom: 10)).make(),
        // <Widget>[
        //   leading ?? Container(), title ?? Container(), trailing ?? Container(),
        // ].hStack(
        //   alignment: MainAxisAlignment.spaceBetween,
        //   axisSize: MainAxisSize.max
        // ).p8(),
      ].vStack(), // header
      child, // body
      // actions
      // (actions ?? []).hStack() // footer
      <Widget>[
        needCancel ? ZButton(
          primary: Colors.redAccent,
          type: ButtonType.Text,
          child: cancel ?? "Cancel".text.make(),
          onPressed: () {
            bool ok = onCancel?.call() ?? true;
            if (ok) Navigator.of(context).pop();
          },
        ) : Container(),
        ...(actions ?? [])
      ].hStack(alignment: MainAxisAlignment.spaceAround, axisSize: MainAxisSize.max),
    ].vStack().box.make();
  }

  bool get needCancel => onCancel != null || cancel != null;
}