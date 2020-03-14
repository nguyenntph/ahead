import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Hello Generator'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
            ],
        ),
        body: _buildSuggestion(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              final Iterable<ListTile> tiles = _saved.map(
                  (WordPair pair) {
                    return ListTile(
                        title: Text(
                            pair.asPascalCase,
                            style: _biggerFont,
                        ),
                    );
                  }
              );

              final List<Widget> divided = ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
              ).toList();

              return Scaffold(
                  appBar: AppBar(
                      title: Text('Saved Text'),
                  ),
                  body: ListView(children: divided),
              );
            },
        ),
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool saved = _saved.contains(pair);

    return ListTile(
        title: Text(
            pair.asPascalCase,
            style: _biggerFont
        ),
        trailing: Icon(
            saved ? Icons.favorite : Icons.favorite_border,
            color: saved ? Colors.red : Colors.blue
        ),
        onTap: () {
          setState(() {
            if (saved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        }
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
