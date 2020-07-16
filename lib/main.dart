import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cocos_test/path_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() async {
  // it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await PathUtil.instance.init("1");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      body: InAppWebView(
        ///storage/emulated/0/web-mobile/index.html
        initialUrl: "file:///storage/emulated/0/web-mobile/index.html",
//        initialFile: "assets/web-mobile/index.html",
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            supportZoom: false,
            useOnLoadResource: true,
            javaScriptEnabled: true,
            debuggingEnabled: false,
            cacheEnabled: true,
            clearCache: true,
            mediaPlaybackRequiresUserGesture:  true,
            disableContextMenu: true,
            useShouldOverrideUrlLoading: true,
          ),
          android: AndroidInAppWebViewOptions(
            domStorageEnabled: true,
            builtInZoomControls: false,
            geolocationEnabled: true,
            allowFileAccessFromFileURLs: true,
            allowUniversalAccessFromFileURLs: true,
            allowFileAccess: true,
            allowContentAccess: true,
            displayZoomControls: false,
            useWideViewPort: true,
            supportMultipleWindows: true,
            networkAvailable: true,
            blockNetworkImage: false,
            mixedContentMode:
            AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
            verticalScrollbarPosition:
            AndroidVerticalScrollbarPosition.SCROLLBAR_POSITION_RIGHT,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
          ),
        ),
        initialHeaders: {},
        onWebViewCreated: (InAppWebViewController controller) {
          webViewController = controller;
          controller.addJavaScriptHandler(handlerName: "handlerName", callback: (List<dynamic> arguments){
            print("=============" + arguments.toString());
            print("array: ${arguments[2].runtimeType.toString()}");
            print("dictionary: ${arguments[3].runtimeType.toString()}");
          });
        },
        onLoadStart: (InAppWebViewController controller, String url) {

        },
        onLoadStop: (InAppWebViewController controller, String url) async {

        },
        onProgressChanged: (InAppWebViewController controller, int progress) {

        },
        onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
          print("=============" + consoleMessage.message);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //
    );
  }

  void _incrementCounter() {
    webViewController.evaluateJavascript(source: "window.appSendJs('hello')");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(PathUtil.instance.externalStoragePath);
    print(File("/storage/emulated/0/web-mobile/index.html").path);
  }
}
