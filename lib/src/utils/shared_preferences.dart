import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ZSharedPreferences {
  ZSharedPreferences._();

  static final ZSharedPreferences _instance = ZSharedPreferences._();

  static ZSharedPreferences get instance => _instance;

  SharedPreferences prefs;

  SharedPreferences get original => prefs;

  factory ZSharedPreferences() {
    return _instance;
  }

  Future<void> init() async {
    if (prefs != null) return Future.value();
    prefs = await SharedPreferences.getInstance();
  }

  /// put object.
  Future<bool> putObject(String key, Object value) {
    if (prefs == null) return null;
    return prefs.setString(key, value == null ? "" : json.encode(value));
  }

  /// get object.
  Map getObject(String key) {
    if (prefs == null) return null;
    String _data = prefs.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  /// put object list.
  Future<bool> putObjectList(String key, List<Object> list) {
    if (prefs == null) return null;
    List<String> _dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    return prefs.setStringList(key, _dataList);
  }

  /// get object list.
  List<Map> getObjectList(String key) {
    if (prefs == null) return null;
    List<String> dataLis = prefs.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }

  /// get string.
  String getString(String key, {String defValue: ''}) {
    if (prefs == null) return defValue;
    return prefs.getString(key) ?? defValue;
  }

  /// put string.
  Future<bool> putString(String key, String value) {
    if (prefs == null) return null;
    return prefs.setString(key, value);
  }

  /// get bool.
  bool getBool(String key, {bool defValue: false}) {
    if (prefs == null) return defValue;
    return prefs.getBool(key) ?? defValue;
  }

  /// put bool.
  Future<bool> putBool(String key, bool value) {
    if (prefs == null) return null;
    return prefs.setBool(key, value);
  }

  /// get int.
  int getInt(String key, {int defValue: 0}) {
    if (prefs == null) return defValue;
    return prefs.getInt(key) ?? defValue;
  }

  /// put int.
  Future<bool> putInt(String key, int value) {
    if (prefs == null) return null;
    return prefs.setInt(key, value);
  }

  /// get double.
  double getDouble(String key, {double defValue: 0.0}) {
    if (prefs == null) return defValue;
    return prefs.getDouble(key) ?? defValue;
  }

  /// put double.
  Future<bool> putDouble(String key, double value) {
    if (prefs == null) return null;
    return prefs.setDouble(key, value);
  }

  /// get string list.
  List<String> getStringList(String key,
      {List<String> defValue: const []}) {
    if (prefs == null) return defValue;
    return prefs.getStringList(key) ?? defValue;
  }

  /// put string list.
  Future<bool> putStringList(String key, List<String> value) {
    if (prefs == null) return null;
    return prefs.setStringList(key, value);
  }

  /// get dynamic.
  dynamic getDynamic(String key, {Object defValue}) {
    if (prefs == null) return defValue;
    return prefs.get(key) ?? defValue;
  }

  /// have key.
  bool haveKey(String key) {
    if (prefs == null) return null;
    return prefs.getKeys().contains(key);
  }

  /// get keys.
  Set<String> getKeys() {
    if (prefs == null) return null;
    return prefs.getKeys();
  }

  /// remove.
  Future<bool> remove(String key) {
    if (prefs == null) return null;
    return prefs.remove(key);
  }

  /// clear.
  Future<bool> clear() {
    if (prefs == null) return null;
    return prefs.clear();
  }

  ///Sp is initialized.
  bool isInitialized() {
    return prefs != null;
  }
}
