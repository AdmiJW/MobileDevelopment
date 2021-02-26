import 'package:flutter/material.dart';
import '../Utilities/listTileFactory.dart';
import 'package:faker/faker.dart';


final _floatingBtn = Column(
  mainAxisAlignment: MainAxisAlignment.end,

  children: <FloatingActionButton>[
    FloatingActionButton(
      onPressed: () {},
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      mini: true,
      child: Icon(Icons.video_call)
    ),
    FloatingActionButton(
      onPressed: (){},
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      child: Icon(Icons.add_ic_call)
    )
  ]
);



class Calls extends StatefulWidget {
  @override
  _CallsState createState() => _CallsState();
}


class _CallsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int idx) {
          idx = (idx % 50) + 1;
          return createCall(
            avatarURL: "assets/${idx < 10? '0':''}$idx.jpg",
            name: faker.person.name(),
            isIncoming: faker.randomGenerator.boolean(),
            isConnected: faker.randomGenerator.boolean(),
            isGroup: faker.randomGenerator.boolean(),
            time: faker.date.dateTime(minYear: 2020, maxYear: 2021)
          );
        },
      ),
      floatingActionButton: _floatingBtn,
    );
  }
}