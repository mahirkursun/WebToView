import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewapp/home.dart';
import 'package:webviewapp/veritabani/VeritabaniYardimcisi.dart';

class WebViewContainer extends StatefulWidget {
  String url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  String _url;
  final _key = UniqueKey();

  _WebViewContainerState(this._url);

  ShakeDetector detector;

  @override
  void initState() {
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      deleteDb();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      detector?.stopListening();
      detector = null;
    });
    super.initState();
  }

  @override
  void dispose() {
    detector?.stopListening();
    super.dispose();
  }

  void deleteDb() async {
    await DatabaseHelper.instance.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url),
        ))
      ],
    ));
  }
}
