import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Container(
          child: Column(
        children: [
          Form(
              child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Titel note',
                    prefixIcon: Icon(Icons.note)),
              ),
              TextFormField(
                minLines: 1,
                maxLines: 4,
                maxLength: 200,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.notes)),
              ),
              ElevatedButton(
                  onPressed: () {
                    showButtomSheet();
                  },
                  child: Text('Add Image For Note')),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Add Notes',
                ),
              ),
            ],
          ))
        ],
      )),
    );
  }

  showButtomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.all(20),
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please Choose Image',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.photo_camera_back_outlined,size: 30,),
                              SizedBox(width: 10,),
                              Text(
                                'From Gallary',
                                style: TextStyle(
                                    fontSize: 16,),
                              ),
                            ],
                          ))),

                  InkWell(
                      onTap: () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.camera_alt_outlined,size: 30,),
                              SizedBox(width: 10,),
                              Text(
                                'From Camera',
                                style: TextStyle(
                                    fontSize: 16,),
                              ),
                            ],
                          ))),
                ],
              ));
        });
  }
}
