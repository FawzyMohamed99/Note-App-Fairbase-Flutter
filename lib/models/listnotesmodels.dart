import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget {
  final notes;

  ListNotes(this.notes);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/logo.PNG',
              fit: BoxFit.fill,
              height: 80,
              width: 80,
            ),
          ),
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text('Title'),
              subtitle: Text('${notes['note']}'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
