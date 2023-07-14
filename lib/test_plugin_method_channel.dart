import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'test_plugin_platform_interface.dart';

/// An implementation of [TestPluginPlatform] that uses method channels.
class MethodChannelTestPlugin extends TestPluginPlatform {

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('test_plugin');

  MethodChannelTestPlugin() {
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall methodCall) async {
    debugPrint('test handleMethodCall $methodCall');
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

}
