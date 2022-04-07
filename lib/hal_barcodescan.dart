
import 'dart:async';

import 'package:flutter/services.dart';

class HalBarcodescan {
  static const MethodChannel _channel = MethodChannel('hal_barcodescan');
  static const cameraAccessDenied = 'PERMISSION_NOT_GRANTED';
  static const userCanceled = 'USER_CANCELED';

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> scan() async => await _channel.invokeMethod('scan');
}
