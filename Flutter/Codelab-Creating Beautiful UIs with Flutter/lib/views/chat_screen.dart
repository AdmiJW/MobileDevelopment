import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:creating_beautiful_ui_with_flutter/widgets/chat_message.dart';



//?============================================
//? Chat Screen Widget
//?============================================
class ChatScreen extends StatefulWidget {
    const ChatScreen({ Key? key }) : super(key: key);

    @override
    _ChatScreenState createState() => _ChatScreenState();
}



//?============================================
//? Chat Screen State
//?============================================
//? Notice the TickerProviderStateMixin, which is required on the widget
//? if we want to implement animations
class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

    // Text controller. Gives more control over text field
    final _textController = TextEditingController();
    // focusNode allows us to give focus back into the text field after sending the message
    final FocusNode _focusNode = FocusNode();
    // list of ChatMessage - Individual messages that are sent by us
    final List<ChatMessage> _messages = [];


    @override
    Widget build(BuildContext context) {
        return Scaffold(

            // * 1 - Appbar
            appBar: AppBar(
                title: const Text('FriendlyChat'),
                elevation: Theme.of(context).platform == TargetPlatform.iOS?
                    0.0: 4.0,  
            ),

            // * 2 - Body
            body: Container(
                child: Column(
                    children: <Widget>[

                        // * 2.1 - List of ChatMessages
                        Flexible( child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            reverse: true,
                            itemBuilder: (_, index)=> _messages[index],
                            itemCount: _messages.length,
                        )),

                        // * 2.2 - Divider
                        const Divider(height: 1.0),

                        // * 2.3 - Text Composer
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                            ),
                            child: _buildTextComposer()
                        )
                    ],
                ),
                decoration: Theme.of(context).platform == TargetPlatform.iOS?
                    BoxDecoration( 
                        border: Border(top: BorderSide(color: Colors.grey[200]!))
                    ):
                    null,
            ),
        );
    }


    // Free animation controllers when this widget is disposed
    @override
    void dispose() {
        for (var message in _messages) {
            message.animationController.dispose();
        }
        super.dispose();
    }


    // Text Composer is the bottom row of application that includes both the
    // text field and the send button
    Widget _buildTextComposer() {
        var textField = TextField(
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration: const InputDecoration.collapsed(
                hintText: 'Send a message'
            ),
            focusNode: _focusNode,
        );

        var sendButton = Theme.of(context).platform == TargetPlatform.iOS?
            CupertinoButton(
                child: const Text('Send'), 
                onPressed: ()=> _handleSubmitted(_textController.text),
            ):
            IconButton(
                icon: const Icon(Icons.send),
                onPressed: ()=> _handleSubmitted(_textController.text),
            );

        return IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    children: <Widget>[
                        Flexible(child: textField),
                        Flexible(flex: 0, child: sendButton),
                    ]
                )
            )
        ); 
    }



    // Submit button event handler
    void _handleSubmitted(String text) {
        if (text.isEmpty) return;           // <- Do nothing if text is empty

        _textController.clear();            // <- Clears the textField

        ChatMessage message = ChatMessage(
            text: text, 
            animationController: AnimationController(
                duration: const Duration(milliseconds: 700),
                vsync: this
            ),
        );

        setState(() {
            _messages.insert(0, message);
        });

        _focusNode.requestFocus();             // <- Set focus back to textField
        message.animationController.forward(); // <- Begin the animation
    }
}

