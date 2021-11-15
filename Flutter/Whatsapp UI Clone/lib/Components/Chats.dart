import "package:flutter/material.dart";
import "../Utilities/listTileFactory.dart";
import "package:faker/faker.dart";


final _button = FloatingActionButton(
  child: Icon(Icons.chat), 
  foregroundColor: Colors.white,
  backgroundColor: Colors.green,
  onPressed: (){}
);




class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int idx) {
          idx = (idx % 50) + 1;
          return createChat(
            avatarURL: "assets/${idx < 10? '0':''}$idx.jpg",
            name: faker.person.name(),
            message: faker.lorem.words(4).join(" "),
            time: faker.date.dateTime(minYear: 2020, maxYear: 2021)
          );
        },
      ),

      floatingActionButton: _button
    );
  }
}