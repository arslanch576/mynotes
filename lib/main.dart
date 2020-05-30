import 'package:flutter/material.dart';
import 'package:mynotes/HomePage.dart';

void main() => runApp(MyNotes());

class MyNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

