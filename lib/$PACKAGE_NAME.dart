
import 'dart:async';

import 'package:flutter/services.dart';

class $PACKAGE_NAME_CAPITAL {
  static const MethodChannel _channel = MethodChannel('$PACKAGE_NAME');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
