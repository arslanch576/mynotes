import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynotes/AddNewNotePage.dart';
import 'package:mynotes/NotesProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Note.dart';

class ShowNoteDetailsPage extends StatefulWidget {
  Note note;

  ShowNoteDetailsPage(this.note);

  @override
  ShowNoteDetailsState createState() => ShowNoteDetailsState(note);
}

class ShowNoteDetailsState extends State {
  Note note;

  deleteNote() async {
    await (await NotesProvider().open()).delete(note);
    Fluttertoast.showToast(
        msg: "Deleted.",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    Navigator.pop(context);
  }

  editNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => AddNewNotePage(
                  note: note,
                ))).then((v) {
      Navigator.pop(context);
    });
  }

  ShowNoteDetailsState(this.note);

  void showDeleteConfirmationDialog() {
    Alert(
      context: context,
      title: "Delete Confirmaton",
      desc: "Are you sure to delete this note permanently?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.green,
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            deleteNote();
            Navigator.pop(context);
          },
          color: Colors.red[400],
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Details"),
        actions: <Widget>[
          GestureDetector(
            onTap: showDeleteConfirmationDialog,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  "DELETE",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: editNote,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                  child: Text(
                "EDIT",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              Text(
                note.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Created: ' + note.createdOn,
                style: TextStyle(color: Colors.black26),
              ),
              Text(
                'Updated' + note.updatedOn,
                style: TextStyle(color: Colors.black26),
              ),
              Text(
                note.content,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
