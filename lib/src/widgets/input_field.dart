import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_zoekits/flutter_zoekits.dart';
import 'package:velocity_x/velocity_x.dart';

enum InputFieldType {
  Switch,
  Input,

  Unknown,
}

// bool => switcher
// options<1, 2, ...> => checker
// options<1> => selector <search>
// string => input
extension InputFieldExt on InputFieldType {

  Widget build(BuildContext context, dynamic value, ValueChanged onChanged, InputFieldOptions opts) {
    final builders = <InputFieldType, Widget Function(BuildContext context, dynamic value, ValueChanged onChanged, InputFieldOptions opts)> {
      InputFieldType.Switch: (context, value, onChanged, opts) {
        return CupertinoSwitch(
          value: value,
          onChanged: onChanged,
        );
      },
      InputFieldType.Input: (context, value, onChanged, opts) {
        return TextField(
          controller: TextEditingController(text: value),
          onChanged: (opts?.editable ?? true) ? onChanged : null,
          decoration: InputDecoration.collapsed(
            hintText: opts?.hintText,
            focusColor: opts?.focusColor ?? Colors.white,
          ),
          
        ).box.width(opts?.width ?? 180).make();
      },

      InputFieldType.Unknown: (context, value, onChanged, opts) {
        return "$value".text.make();
      }
    };

    return builders[this]?.call(context, value, onChanged, opts);
  }

  InputFieldType from(dynamic value, [InputFieldOptions opts]) {
    if (value is bool) return InputFieldType.Switch;
    if (value is String) return InputFieldType.Input;
    return InputFieldType.Unknown;
  }

}

class InputFieldOptions {

  final ValueChanged onChanged;
  final bool editable;
  final double width;
  final String hintText;
  final Color focusColor;

  InputFieldOptions({
    this.onChanged,
    this.editable = true,
    this.width = 185,
    this.hintText = "Please input ...",
    this.focusColor,
  });
}

class InputField extends StatefulWidget {

  final dynamic value;
  final InputFieldOptions opts;

  const InputField({
    Key key,
    this.value,
    this.opts,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  InputFieldType get _type {
    return InputFieldType.Unknown.from(widget.value);
  }

  dynamic value;

  _onChanged(dynamic v) {
    // invalite
    if (_type == InputFieldType.Input) {
      value = v;
    } else {
      setState(() => value = v);
    }
    
    // TODO: auto validate
    widget.opts?.onChanged?.call(v);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _type.build(context, value, _onChanged, widget.opts);
  }
}