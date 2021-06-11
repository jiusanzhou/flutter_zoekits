

import 'package:flutter/material.dart';

ImageProvider imageFromString(String path) {
  assert(path != null
    || path != "");

  return !path.startsWith("https?://")
    ? AssetImage(path)
    : NetworkImage(path);
} 