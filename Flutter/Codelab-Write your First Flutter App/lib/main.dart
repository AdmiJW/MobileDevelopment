import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


// Main will execute only runApp function, which takes in an instance of App Class
void main() => runApp(MyApp());



//? Flutter provides built-in Widgets, like Scaffold, or we can also create
//? our own widget, minimum:
//?     1 - Extend StatelessWidget (or StatefulWidget)
//?     2 - Override the build method to return widgets that it contains
//?
//? If you have proper plugin installed, you can type stfl or stls for quick
//? boilerplate code setup


//? Our top level application class - Extends StatelessWidget, and need to
//? override the build() method to return an app instance
class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context)=> MaterialApp(
        title: 'Startup Name Generator',
        theme: ThemeData( 
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white
            )
        ),
        home: SuggestionView()
    );
}




class SuggestionView extends StatefulWidget {
    const SuggestionView({ Key? key }) : super(key: key);

    //? One of the StatefulWidget lifecycle methods - createState() 
    @override
    _SuggestionViewState createState() => _SuggestionViewState();
}

//? State for SuggestionView is mutable. We will store the state data inside
//? of the State
class _SuggestionViewState extends State<SuggestionView> {
    final _suggestions = <WordPair>[];
    final _saved = <WordPair>{};
    final _biggerFont = const TextStyle(fontSize: 18);

    
    @override
    Widget build(BuildContext context) {
        var appBar = AppBar(
            title: const Text('Startup Name Generator'),
            actions: [
                IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: _pushSavedView,
                    tooltip: 'Saved Suggestions',
                )
            ],
        );

        return Scaffold(
            appBar: appBar,
            body: _buildSuggestions()    
        );
    }


    // Event handler for switching to saved view
    void _pushSavedView() {
        Navigator.of(context).push(
            MaterialPageRoute<void>(
                builder: (context)=> SavedSuggestionView(saved: _saved)
            ), 
        );
    }


    // Builds a ListView of suggestions
    Widget _buildSuggestions() {
        // ListView is a Widget for lists. It has static builder() method for
        // building lists, best used for infinite scrolling. 
        // itemBuilder is a callback function that is called for each index of
        // listview that should be on screen.
        return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemBuilder: (BuildContext _context, int i) {
                if (i.isOdd) return Divider();
                final int index = i ~/ 2;

                // If the list of suggestions is already not enough, add new suggestions
                if (index >= _suggestions.length) {
                    _suggestions.addAll( generateWordPairs().take(10) );
                }

                // Return a ListTile for this index
                return _buildListTile(_suggestions[index]);
            }
        );
    }


    Widget _buildListTile(WordPair pair) {
        final isSaved = _saved.contains(pair);

        return ListTile(
            title: Text( pair.asPascalCase, style: _biggerFont ),
            trailing: Icon(
                isSaved? Icons.favorite: Icons.favorite_border_rounded,
                color: isSaved? Colors.red: null,
                semanticLabel: isSaved? 'Remove from Saved': 'Save',
            ),
            // Tap event handler. setState will run the function given in param,
            // then it will call build() method again to update the view
            onTap: ()=> setState(() {
                if (isSaved) _saved.remove(pair);
                else _saved.add(pair);
            })
        );
    }
}




class SavedSuggestionView extends StatelessWidget {
    final Iterable<WordPair> _saved;
    final _biggerFont = const TextStyle(fontSize: 18);

    const SavedSuggestionView({ Key? key, required Iterable<WordPair> saved }) 
        : _saved = saved, super(key: key);

    @override
    Widget build(BuildContext context) {
        final tiles = _saved.map( (pair)=> 
            ListTile( title: Text( pair.asPascalCase, style: _biggerFont ), )
        );

        final divided = tiles.isNotEmpty? 
            ListTile.divideTiles(
                context: context,
                tiles: tiles,
            ).toList()
            : <Widget>[];

        return Scaffold(
            appBar: AppBar( title: const Text('Saved Suggestions') ),
            body: ListView(children: divided),
        );
    }
}







