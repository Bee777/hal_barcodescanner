import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hal_barcodescan/hal_barcodescan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _barcode = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await HalBarcodescan.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future scan() async {
    try {
      final String barcode = await HalBarcodescan.scan();
      setState(() => _barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == HalBarcodescan.cameraAccessDenied) {
        setState(() {
          _barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => _barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => _barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => _barcode = 'Unknown error: $e');
    }

    print('ok');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HAL Barcode Scaner Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Text('Running on: $_platformVersion\n'),
              const SizedBox(
                height: 22,
              ),
              Container(
                child:
                    MaterialButton(onPressed: scan, child: const Text("Scan")),
                padding: const EdgeInsets.all(8.0),
              ),
              Text(_barcode),
            ],
          ),
        ),
      ),
    );
  }
}
