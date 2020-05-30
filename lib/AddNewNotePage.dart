import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/NotesProvider.dart';

import 'Note.dart';

class AddNewNotePage extends StatefulWidget {
  Note note;

  AddNewNotePage({this.note});

  @override
  AddNewNoteState createState() => AddNewNoteState(note: note);
}

class AddNewNoteState extends State {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Note note;
  bool isForUpdate = false;

  AddNewNoteState({this.note}) {
    if (note == null)
      note = new Note();
    else {
      isForUpdate = true;
      title.text = note.title;
      content.text = note.content;
    }
  }

  Future<void> saveNote() async {
    String formattedDate =
        DateFormat('dd/MM/yy - hh:mm a').format(DateTime.now());
    NotesProvider notesProvider = await NotesProvider().open();
    note
      ..title = title.text
      ..content = content.text
      ..updatedOn = formattedDate;
    if (isForUpdate) {
      await notesProvider.delete(note);
      note.id=null;
      await notesProvider.insert(note);
    } else {
      note.createdOn = formattedDate;
      await notesProvider.insert(note);
    }
    Fluttertoast.showToast(
        msg: "Saved.",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Note"),
        actions: <Widget>[
          Center(
              child: FlatButton(
            onPressed: saveNote,
            child: Text(
              "SAVE",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Enter note title",
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: content,
                  maxLines: 100,
                  decoration: InputDecoration(
                      labelText: "Text", hintText: "Enter note text"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
