import 'package:design_app_notes/card/editnotes.dart';
import 'package:design_app_notes/card/viewnotes.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget {
  final  notes,docid;


  ListNotes({this.notes,this.docid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ViewNotes(notes: notes,);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                '${notes["imageurl"]}',
                fit: BoxFit.fill,
                height: 80,
                width: 80,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text("${notes["title"]}"),
                subtitle: Text('${notes['note']}'),
                trailing: IconButton(
                  onPressed: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return EditNotes(docid: docid,list: notes,);
                    }));
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
