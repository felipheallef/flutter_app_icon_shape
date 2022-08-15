import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:app_icon_shape/app_icon_shape.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_drawing/path_drawing.dart';

import 'filled_path_painter.dart';
import 'gen/assets.gen.dart';

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
  Path? _appMask;
  final _appIconShapePlugin = AppIconShape();

  final shapes = {
    'Square': 'M50,0L100,0 100,100 0,100 0,0z',
    'Squircle': 'M50,0 C10,0 0,10 0,50 0,90 10,100 50,100 90,100 100,90 100,50 100,10 90,0 50,0 Z',
    'Circle': 'M50 0A50 50,0,1,1,50 100A50 50,0,1,1,50 0',
    'Teardrop': 'M50,0A50,50,0,0 1 100,50 L100,85 A15,15,0,0 1 85,100 L50,100 A50,50,0,0 1 50,0z',
  };

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
      platformVersion = await _appIconShapePlugin.getPlatformVersion() ??
          'Unknown platform version';
      _appMask = await _appIconShapePlugin.getAppIconMask();
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

  Widget _getAdaptiveIcon(Path path, Image icon, double pixelRatio) {
    return Stack(
      children: [
        CustomPaint(
          size: Size.square(288 / pixelRatio),
          painter: FilledPathPainter(
            path: path,
            color: Colors.blue,
          ),
        ),
        Container(
          width: 288 / pixelRatio,
          height: 288 / pixelRatio,
          alignment: Alignment.center,
          child: SizedBox(
            width: 200 / pixelRatio,
            height: 200 / pixelRatio,
            child: icon,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final pixelRatio = MediaQuery.of(context).devicePixelRatio;
          return Column(
            children: [
              Flexible(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Launcher icon shape:\n'),
                          ),
                        ),
                        if (_appMask != null)
                          Center(
                            child: CustomPaint(
                              size: Size.square(288 / pixelRatio),
                              painter: FilledPathPainter(
                                path: _appMask!,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Adaptive icon example:\n'),
                          ),
                        ),
                        _getAdaptiveIcon(
                          _appMask!,
                          Assets.icons.iconFlutterSolid.image(),
                          pixelRatio,
                        ),
                      ],
                    ),
                    for (final shape in shapes.keys)
                      Center(
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('$shape:\n'),
                              ),
                            ),
                            _getAdaptiveIcon(
                              parseSvgPathData(shapes[shape]!),
                              Assets.icons.iconFlutterSolid.image(),
                              pixelRatio,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 38.0),
              //   child: Text('Most common adaptive icon shapes:'),
              // ),
            ],
          );
        }),
      ),
    );
  }
}
