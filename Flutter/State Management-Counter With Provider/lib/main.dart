import "package:flutter/material.dart";
import 'package:provider/provider.dart';

void main()=> runApp(const MyApp());


//? Motivation:
//? When you build an application, sooner or later you may realize states on
//? certain page or route might need to be accessed by widgets in another
//? page or route. 
//? 
//? Using StatefulWidgets, we could make the lowest common ancestors of the
//? state-requiring widgets to share the state, but this can cause some issues
//? especially if we have a deep widget tree
//?
//? 1 - Callback drilling - Passing the callback to dispatch actions deep into
//?                         the widget tree
//? 2 - Unwanted repaint - Calling setState() causes all descendants to rebuild.
//?
//? Instead, we could use the `provider` package to help manage states. It's
//? like Redux in web frameworks!


//? ChangeNotififer
//?
//? A ChangeNotifier class is basically a state (or model) for our application
//? For example in a shopping app, we could create a CartModel which holds the
//? state of the shopping cart
//?
//? 1.  It must extend ChangeNotifier to notify about changes to the state.
//? 2.  When state changes, we call notifyListeners() to notify all the subscribers
//?     listening to the state
class Counter extends ChangeNotifier {
    int _count = 0;
    int get count => _count;

    void incrementCounter() {
        ++_count;
        notifyListeners();
    }
}



class MyApp extends StatelessWidget {
    const MyApp({Key? key}): super(key: key);

    static final theme = ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
    );


    @override
    Widget build(BuildContext context) {
        // Material app - UI and stuff
        var materialApp = MaterialApp( 
            title: 'Counter With Provider',
            theme: theme,
            home: const MyHomePage(title: 'Counter With Provider')
        );


        //? Provider
        //?
        //? A provider is a node in widget tree that provides an instance of the
        //? state (ChangeNotifier) - An instance of Counter
        //? All the child widgets under this node will have access to the state.
        //?
        //? Here we use MultiProvider, which it can hold multiple provider at one
        //? same level.
        //? 
        //? If we only require one provider (sure that in future you won't extend),
        //? You can just use ChangeNotifierProvider on its own
        //?
        //? Use constructor ChangeNotifierProvider(create: ()=>...) to create
        //? the ChangeNotifier (state), or you can do as below: using
        //? ChangeNotifierProvider.value(value: ...);
        var provider = MultiProvider(
            providers: [
                ChangeNotifierProvider.value(value: Counter()),
            ],
            child: materialApp
        );

        return MaterialApp( 
            title: 'Counter With Provider',
            theme: theme,
            home: provider
        );
    }
}





class MyHomePage extends StatelessWidget {
    final String title;

    // Constructor
    const MyHomePage({Key? key, required this.title}): super(key: key);


    //? Accessing the state (ChangeNotifier) from the Provider
    //?
    //? To access state from the provider, we have two approaches according to
    //? the documentation
    //? 
    //? 1 - Using Consumer<type>( builder:... ) as the wrapping widget.
    //?     The builder is a function that builds the widgets, while you have
    //?     access to the state, as well as previously built child widgets
    //?     for optimization (if you don't want child to be rebuilt)
    //?
    //? 2 - Using Provider.of<type>(context, listen:...)
    //?     The return value of this call would be the state (ChangeNotifier)
    //?     itself. This is also the underlying logic of Consumer widget.
    //?     You may set listen to false, which the widget won't be rebuilt even
    //?     if the state changes. This is useful if the widget only dispatch
    //?     actions
    void _onIncrementPress(BuildContext context) {
        // From the context, look up into the widget tree to find the first
        // place where Counter state is provided.
        // The <Counter> generic specify what type of provider to look for
        // listen: false becuase we don't listen to any values, just dispatch action
        Provider.of<Counter>(context, listen: false).incrementCounter();
    }


    @override
    Widget build(BuildContext context) {
        // Obtain the state value
        int counter = Provider.of<Counter>(context).count;

        return Scaffold( 
            appBar: AppBar( title: Text(title) ),

            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        const Text('You have pushed the button this many times:'),
                        Text(
                            '$counter', 
                            style: Theme.of(context).textTheme.headline4
                        ),
                    ],
                ),
            ),

            floatingActionButton: FloatingActionButton(
                onPressed: ()=> _onIncrementPress(context),
                tooltip: 'Increment Counter',
                child: const Icon(Icons.add),
            ),
        );
    }
}