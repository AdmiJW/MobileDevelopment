import 'package:flutter/material.dart';



//?============================================
//? Chat Message
//?============================================
class ChatMessage extends StatelessWidget {

    const ChatMessage({ 
        Key? key, required this.text, required this.animationController 
    }) : super(key: key);

    static const String _name = "AdmiJW";
    final String text;
    // For each widget that needs animation, it should have a animationController
    // with it
    final AnimationController animationController;

    @override
    Widget build(BuildContext context) {
        var circleAvatar = Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar( child: Text(_name[0] ) )
        );

        var nameText = Text(
            _name, 
            style: Theme.of(context).textTheme.headline4
        );

        var contentText = Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text( text )
        );

        // SizeTransition animates the size of the widget.
        return SizeTransition(
            sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
            axisAlignment: -1,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                    children: <Widget>[
                        circleAvatar,
                        Expanded( child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[ nameText, contentText ],
                        )),
                    ],
                ),
            ),
        );
        
    }
}




