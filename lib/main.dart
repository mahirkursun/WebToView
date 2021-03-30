import 'package:flutter/material.dart';
import 'package:webviewapp/home.dart';
import 'package:webviewapp/veritabani/VeritabaniYardimcisi.dart';
import 'package:webviewapp/web_view_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<String> linkGetir = Future<String>.delayed(
    const Duration(milliseconds: 100),
    () async => await DatabaseHelper.instance.kayitKontrol(),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: linkGetir,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return MaterialApp(
              title: 'WebToView',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  fontFamily: "Arial",
                  textTheme: TextTheme(
                      button: TextStyle(color: Colors.white, fontSize: 18.0),
                      title: TextStyle(color: Colors.red))),
              home: WebViewContainer(snapshot.data),
            );
          }
        } else {
          return MaterialApp(
            title: 'WebToView',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: "Arial",
                textTheme: TextTheme(
                    button: TextStyle(color: Colors.white, fontSize: 18.0),
                    title: TextStyle(color: Colors.red))),
            home: Home(),
          );
        }
      },
    );
  }
}
