import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_app_notes/models/listnotesmodels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('login');
              },
              icon: Icon(Icons.exit_to_app_sharp))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addnotes');
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          child: FutureBuilder(
              future: notesref
                  .where("userId",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                            onDismissed: (diretion) async {
                              await notesref
                                  .doc(snapshot.data.docs[i].id)
                                  .delete();
                              await FirebaseStorage.instance
                                  .refFromURL(snapshot.data.docs[i]["imageurl"])
                                  .delete();
                              print('===============================');
                              print('delete');
                            },
                            key: UniqueKey(),
                            child: ListNotes(
                              notes: snapshot.data.docs[i],
                              docid: snapshot.data.docs[i].id,
                            ));
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}
