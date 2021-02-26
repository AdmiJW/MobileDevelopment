import 'package:flutter/material.dart';

//  Components
import './Components/AppBar.dart';
import './Utilities/listTileFactory.dart';
import './Components/Chats.dart';
import './Components/Status.dart';
import './Components/Calls.dart';

void main() => runApp( MyWhatsApp() );



final _themeData = ThemeData(
  primaryColor: Colors.green[900]
);




class MyWhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyWhatsApp',
      theme: _themeData,
      home: MyWhatsAppHome(title: "WhatsApp")
    );
  }
}


class MyWhatsAppHome extends StatefulWidget {
  String title = 'MyWhatsApp';
  MyWhatsAppHome({Key key, this.title}): super(key: key);

  @override
  _MyWhatsAppHomeState createState() => _MyWhatsAppHomeState();
}



class _MyWhatsAppHomeState extends State<MyWhatsAppHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: WhatsAppAppBar(title: widget.title),
        body: TabBarView(
          children: <Widget>[
            Chats(),       //  Each Page of Tab Here!
            Status(),
            Calls()
          ]
        )
      ),
    );
  }
}