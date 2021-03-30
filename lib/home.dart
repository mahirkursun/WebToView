import 'package:flutter/material.dart';
import 'package:webviewapp/link.dart';
import 'package:webviewapp/veritabani/VeritabaniYardimcisi.dart';
import 'package:webviewapp/web_view_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String url;

class _HomeState extends State<Home> {
  final myController = TextEditingController(text: url);
  List<Link> taskList = new List();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('WebToView'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          TextField(
            autofocus: true,
            controller: myController,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 40.0)),
              hintText: "Link Giriniz..",
              suffixIcon: IconButton(
                onPressed: () async {
                  _addToDb();
                  _handleURLButtonPress(myController.text);
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.blue[900],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToDb() async {
    String task = myController.text;
    var id = await DatabaseHelper.instance.insert(Link(link: task));
    setState(() {
      taskList.insert(0, Link(id: id, link: task));
    });
  }

  void _handleURLButtonPress(String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}
