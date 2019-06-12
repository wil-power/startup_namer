import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.grey,
        ),
        home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordState();
}

class RandomWordState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _testPage,
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      /* the itemBuilder callback is called once per suggested
                      word pairing, and places each suggestion into a listTile
                      row. for even rows, the function adds a listTile row for
                      the word pairing. for odd rows, the function adds a Divider
                      widget to visually separate the entries. Note that the divider
                      may be difficult to see on smaller devices.
                   */
      itemBuilder: (BuildContext _context, int i) {
        // add a one-pixel-high divider widget before each row
        // in the listView
        if (i.isOdd) return Divider();

        // number of word pairings in the lv minus the divider
        final int index = i ~/ 2; // this returns an integer instead of a double

        if (index >= _suggestions.length) {
          // end of word pairings. generate more
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ExpansionTile> tiles = _saved.map(
            (WordPair pair) {
              return ExpansionTile(
                title: Text(pair.asPascalCase, style: _biggerFont),
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new OutlineButton(
                        child: new Text("test"),
                        color: Colors.purple,
                        onPressed: () => {},
                      ),
                      new RaisedButton(
                        child: new Text("raised button"),
                        color: Colors.purple,
                        onPressed: () => {},
                      ),
                      new FlatButton(
                        child: new Text("flat button"),
                        color: Colors.purple,
                        onPressed: () => {},
                      )
                    ],
                  )
                ],
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  void _testPage() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: null,
            body: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: <Widget>[
                  new Text("Sign In",
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  new TextField(
                    
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
