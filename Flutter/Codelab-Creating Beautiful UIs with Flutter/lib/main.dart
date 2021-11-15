import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:creating_beautiful_ui_with_flutter/views/chat_screen.dart';



void main() => runApp(const FriendlyChatApp());


// Themes for the application
final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
        .copyWith(secondary: Colors.orangeAccent[400]),
);




class FriendlyChatApp extends StatelessWidget {
    const FriendlyChatApp({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'FriendlyChat',
            theme: defaultTargetPlatform == TargetPlatform.iOS? 
                kIOSTheme: 
                kDefaultTheme,
            home: const ChatScreen()
        );
    }
}








