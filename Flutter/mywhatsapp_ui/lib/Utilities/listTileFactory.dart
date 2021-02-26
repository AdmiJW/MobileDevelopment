import 'package:flutter/material.dart';


final _padding = EdgeInsets.symmetric(vertical: 10, horizontal: 15);
final _titleStyle = TextStyle(
  fontSize: 18
);



//  Creates a chat ListTile, provide avatarURL, name, message, and time
ListTile createChat({
  avatarURL, 
  name: 'Anonymous',
  message: 'Lorem Ipsum sit Dolor Amet',
  time
}) {
  avatarURL ??= 'assets/user.png';
  time ??= DateTime.now();
  time = "${time.day}/${time.month}/${time.year}";

  return ListTile(
    leading: CircleAvatar(backgroundImage: AssetImage(avatarURL), radius: 30, ),
    title: Text(name, style: _titleStyle), 
    subtitle: Text(message),
    trailing: Text(time ??= "NA/NA/NA"),

    contentPadding: _padding
  );
}



//  Creates a call ListTile, provide avatarURL, name, message, and time
ListTile createCall({
  avatarURL,
  name: 'Anonymous',
  isIncoming: false,
  isConnected: false,
  isGroup: false,
  time
}) {
  avatarURL ??= 'assets/user.png';
  time ??= DateTime.now();
  time = "${time.day}/${time.month}/${time.year}";

  final icon = Icon( isIncoming? Icons.call_received: Icons.call_made,
    color: isConnected? Colors.green: Colors.red, size: 18);
  final button = IconButton(icon: Icon(isGroup? Icons.video_call: Icons.call),
    color: Colors.green[700], onPressed:(){} );
 
  return ListTile( 
    leading: CircleAvatar(backgroundImage: AssetImage(avatarURL), radius: 30),
    title: Text(name, style: _titleStyle),
    subtitle: Row(
      children: <Widget>[
        Container(child: icon, padding: EdgeInsets.only(right: 5)),
        Text(time)
      ]
    ),
    trailing: button,

    contentPadding: _padding,
  );
}




ListTile createStory({
  avatarURL,
  name: 'Anonymous',
  time
}) {
  avatarURL ??= 'assets/user.png';
  time ??= DateTime.now();
  time = "${time.day}/${time.month}/${time.year}";

  return ListTile(
    leading: CircleAvatar(backgroundImage: AssetImage(avatarURL), radius: 30 ),
    title: Text(name, style: _titleStyle),
    subtitle: Text(time),

    contentPadding: _padding,
  );
}


ListTile createMyStatus() {
  return ListTile(
    contentPadding: _padding,
    leading: Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        CircleAvatar(backgroundImage: AssetImage('assets/user.png'), radius: 30),
        Container(
          decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          child: Icon(Icons.add, color: Colors.white)
        )
      ]
    ),
    title: Text("My status", style: _titleStyle),
    subtitle: Text("Tap to add status update")
  );
}