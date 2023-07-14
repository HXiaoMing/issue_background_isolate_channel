import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:test_plugin/test_plugin.dart';
import 'package:test_plugin/test_plugin_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('onTap');
                      _handleClick();
                    },
                    child: const Text('getPlatformVersion'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleClick() async {
    final platformVersion =
        await compute<RootIsolateToken, String>((token) async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(token);
      final version = await TestPluginPlatform.instance.getPlatformVersion();
      debugPrint('getPlatformVersion $version');
      return version ?? '';
    }, RootIsolateToken.instance!);
    setState(() {
      _platformVersion = platformVersion;
    });
  }
}
