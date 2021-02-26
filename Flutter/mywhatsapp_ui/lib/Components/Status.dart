import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../Utilities/listTileFactory.dart';


final _updateTitle = Container( 
  decoration: BoxDecoration(color: Colors.grey[300]),
  child: Padding(
    padding: EdgeInsets.all(15),
    child: Text("Viewed updates")
  )
);



final _floatingBtn = Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: <FloatingActionButton>[
    FloatingActionButton(
      onPressed: (){},
      child: Icon(Icons.create),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      mini: true
    ),
    FloatingActionButton(
      onPressed: (){},
      child: Icon(Icons.camera_alt),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
    )
  ],
);


final _stories = <ListTile>[
  for (var i = 1; i <= 3; ++i) createStory(
    avatarURL: "assets/0$i.jpg",
    name: faker.person.name(),
    time: faker.date.dateTime(minYear: 2020, maxYear: 2021)
  )
];



class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}



class _StatusState extends State<Status> {
  @override 
  Widget build( BuildContext context ) {
    return Scaffold(  
      floatingActionButton: _floatingBtn,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(child: createMyStatus() ),
          _updateTitle,
          Expanded(
            child: ListView(children: _stories)
          )
        ]
      )
    );
  }
}


