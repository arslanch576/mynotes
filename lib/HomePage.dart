import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynotes/AddNewNotePage.dart';
import 'package:mynotes/NotesProvider.dart';
import 'package:mynotes/ShowNoteDetailsPage.dart';
import 'package:sqflite/sqflite.dart';
import 'Note.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notesList = [];
  NotesProvider notesProvider;

  Future<void> getNotesFromDatabase() async {
    if (notesProvider == null) notesProvider = await NotesProvider().open();
    List<Note> notes = await notesProvider.getAllNotes();
    notesList.clear();
    setState(() {
      notesList.addAll(notes);
    });
  }

  void openNote(Note note) {
    Navigator.push(context,
        MaterialPageRoute(builder: (c) => ShowNoteDetailsPage(note))).then((v) {
      getNotesFromDatabase();
    });
  }

  @override
  void initState() {
    super.initState();
    getNotesFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: notesList.length,
          itemBuilder: (context, position) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(5),
              child: InkWell(
                onTap: () {
                  openNote(notesList[position]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        notesList[position].title,
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        notesList[position].content,
                        style: TextStyle(fontSize: 14),
                        maxLines: 3,
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                      Text(
                        'Created on: ' + notesList[position].createdOn,
                        style: TextStyle(color: Colors.black38),
                      ),
                      Text(
                        'Updated on: ' + notesList[position].updatedOn,
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewNotePage()));
          getNotesFromDatabase();
        },
        tooltip: 'Create new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
