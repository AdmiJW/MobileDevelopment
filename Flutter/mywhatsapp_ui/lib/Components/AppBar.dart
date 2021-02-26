import 'package:flutter/material.dart';


AppBar WhatsAppAppBar({String title = 'WhatsApp'}) {
  return AppBar(
    title: Text(title),
    actions: <Widget>[
      IconButton(icon: Icon(Icons.search), onPressed: (){} ),
      IconButton(icon: Icon(Icons.more_vert), onPressed: (){} )
    ],
    bottom: TabBar(
      tabs: <Tab>[
        Tab(text: 'CHATS'),
        Tab(text: 'STATUS'),
        Tab(text: 'CALLS')
      ]
    )
  );
}