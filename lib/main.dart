import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(Ahead());

class Ahead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ahead - Budgeting that works',
        home: RandomWords()
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Hello Generator'),
        ),
        body: _buildSuggestion(),
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
