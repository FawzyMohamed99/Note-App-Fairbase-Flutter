import 'package:design_app_notes/home/homepage.dart';
import 'package:design_app_notes/models/listnotesmodels.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [
    {
      "note": "ok",
      "image": "logo.png",
    },
    {
      "note": "ok1",
      "image": "logo.png",
    },
    {
      "note": "ok2",
      "image": "logo.png",
    },
    {
      "note": "ok3",
      "image": "logo.png",
    },
    {
      "note": "ok4",
      "image": "logo.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.of(context).pushNamed('addnotes');
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, i) {
              return Dismissible(key: Key('${i}'), child: ListNotes(notes[i]));
            }),
      ),
    );
  }
}
