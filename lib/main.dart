import 'package:flutter/material.dart';
import 'package:ahead/src/list.dart';

void main() => runApp(Ahead());

class Ahead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ahead - Budgeting that works',
        theme: ThemeData(
            primaryColor: Colors.red,
        ),
        home: RandomWords()
    );
  }
}
