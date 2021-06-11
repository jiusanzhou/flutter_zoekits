
import 'dart:io';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PlatformUtils {
  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<Map<String, dynamic>> getCommonDeviceInfo() async {
    Map<String, dynamic> _data = {};
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var r = await deviceInfo.androidInfo;
      _data["os"] = "android";
      _data["version"] = "${r.version.baseOS},${r.version.sdkInt},${r.version.release}";
      _data["androidId"] = r.androidId;
      _data["brand"] = r.brand;
      _data["device"] = r.device;
      _data["product"] = r.product;
      _data["model"] = r.model;
    } else if (Platform.isIOS) {
      var r = await deviceInfo.iosInfo;
      _data["os"] = "ios";
      _data["version"] = r.systemVersion;
      _data["name"] = r.systemName;
      _data["model"] = r.model;
      _data["udid"] = r.identifierForVendor;
    }

    return _data;
  }

  static Future<String> getIMEI() async {
    return ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false);
  }

  static Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      return await deviceInfo.iosInfo;
    } else {
      return null;
    }
  }
}