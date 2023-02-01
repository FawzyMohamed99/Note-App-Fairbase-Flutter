import 'package:flutter/material.dart';

class ViewNotes extends StatefulWidget {
  final notes;
  const ViewNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Notes"),),
      body: Container(child: Column(
        children: [
          Container(
              child: Image.network(
                "${widget.notes['imageurl']}",
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "${widget.notes['title']}",
                style: Theme.of(context).textTheme.headline5,
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "${widget.notes['note']}",
                style: Theme.of(context).textTheme.bodyText2,
              )),
        ],
      ),),
    );
  }
}
