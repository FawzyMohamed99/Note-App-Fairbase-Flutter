import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_app_notes/components/lodingalertdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'dart:math';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditNotes extends StatefulWidget {
  final docid,list;
  const EditNotes({Key? key, this.docid, this.list}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  GlobalKey<FormState> formstat = GlobalKey<FormState>();
  var title, note, imageurl;
  late Reference ref;
  File? file;

  editNotes(context) async {
    var fromdata = formstat.currentState;
    if (file == null) {
      if (fromdata != null && fromdata.validate()) {
        showLoading(context);
        fromdata.save();

        await notesref.doc(widget.docid).update(
            {
              "title": title,
              "note": note,
              "userId": FirebaseAuth.instance.currentUser!.uid
            });
        Navigator.of(context).pushNamed('homepage');
      } else {
        if (fromdata != null && fromdata.validate()) {
          showLoading(context);
          fromdata.save();
          await ref.putFile(file!);
          imageurl = await ref.getDownloadURL();
          await notesref.doc(widget.docid).update(
              {"title": title, "note": note, "imageurl": imageurl,
                "userId": FirebaseAuth.instance.currentUser!.uid});
          Navigator.of(context).pushNamed('homepage');
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Container(
          child: Column(
            children: [
              Form(
                  key: formstat,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: widget.list['title'],
                        onSaved: (val) {
                          title = val;
                        },
                        validator: (val) {
                          if (val!.length > 15) {
                            return "title can't to be larger than 15 letter";
                          } else if (val.length < 2) {
                            return "title can't to be less than 2 letter";
                          }
                          return null;
                        },
                        maxLength: 30,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Titel note',
                            prefixIcon: Icon(Icons.note)),
                      ),
                      TextFormField(
                        initialValue: widget.list['note'],
                        onSaved: (val) {
                          note = val;
                        },
                        validator: (val) {
                          if (val!.length > 255) {
                            return "Notes can't to be larger than 255 letter";
                          } else if (val.length < 10) {
                            return "Notes can't to be less than 10 letter";
                          }
                          return null;
                        },
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
                            showButtomSheet(context);
                          },
                          child: Text('Edit Image For Note')),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await editNotes(context);
                        },
                        child: Text(
                          'Edit Notes',
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }

  showButtomSheet(context) {
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
                    'Edit Image',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  InkWell(
                      onTap: () async {
                        var picked = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          file = File(picked.path);
                          var rand = Random().nextInt(10000);
                          var imagename = "$rand" + basename(picked.path);
                          ref = FirebaseStorage.instance
                              .ref("images")
                              .child("$imagename");
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.photo_camera_back_outlined,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'From Gallary',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ))),
                  InkWell(
                      onTap: () async {
                        var picked = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (picked != null) {
                          file = File(picked.path);
                          var rand = Random().nextInt(10000);
                          var imagename = "$rand" + basename(picked.path);
                          ref = FirebaseStorage.instance
                              .ref("images")
                              .child("$imagename");
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'From Camera',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ))),
                ],
              ));
        });
  }
}


