import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
    return MaterialApp(title: 'Startup Name Generator', home: RandomWords());
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  static final double containerSize = 20.0;

  @override
  Widget build(BuildContext context) {
    Widget _buildRow(WordPair pair) {
      final bool alreadySaved = _saved.contains(pair);

      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
//        trailing: Icon(
//          alreadySaved ? Icons.favorite : Icons.favorite_border,
//          color: alreadySaved ? Colors.red : null,
//        ),
        trailing: Container(
            margin: EdgeInsets.only(right: 10),
            width: containerSize,
            height: containerSize,
            child: FlareActor("assets/Favorite.flr",
                shouldClip: false,
                // Play the animation depending on the state.
                animation:
                    alreadySaved ? "Favorite" : "Unfavorite" //_animationName
                )),
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
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext _context, int i) {
            if (i.isOdd) {
              return const Divider();
            }
            final int index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          });
    }

    void _pushSaved() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );
            final List<Widget> divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();

            return new Scaffold(
              appBar: new AppBar(
                title: const Text('Saved Suggestions'),
              ),
              body: new ListView(
                  padding: const EdgeInsets.all(16.0), children: divided),
            );
          },
        ),
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
