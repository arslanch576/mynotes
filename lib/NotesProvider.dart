import 'package:sqflite/sqflite.dart';

import 'Note.dart';

class NotesProvider{

   Database db;
   
   String createNotesTableQuery=
   '''create table ${Note.TABLE_NAME}(
   ${Note.COLUMN_ID} integer primary key autoincrement,
   ${Note.COLUMN_TITLE} text,
   ${Note.COLUMN_CONTENT} text,
   ${Note.COLUMN_CREATED_ON} text,
   ${Note.COLUMN_UPDATED_ON} text
   )''';
   
   Future<NotesProvider> open() async {
      String path = await getDatabasesPath();
      path=path+ "notesdb.db";
      db= await openDatabase(path, version: 2, onCreate: (Database db, int version){
         db.execute(createNotesTableQuery);
      });
      return this;
   }
   
   Future<Note> insert(Note note) async {
      note.id=await db.insert(Note.TABLE_NAME, note.toMap());
      return note;
   }
   
   Future<void> update(Note note) async {
      await db.update(Note.TABLE_NAME, note.toMap(), where: '${Note.COLUMN_ID}= ?', whereArgs: [note.id]);
   }
   
   Future<void> delete(Note note) async {
      await db.delete(Note.TABLE_NAME, where: '${Note.COLUMN_ID}=?', whereArgs: [note.id]);
   }
   
   Future<List<Note>> getAllNotes() async {
      List<Map> rows = await db.query(Note.TABLE_NAME, orderBy: '${Note.COLUMN_ID} DESC');
      return rows.map((Map row)=>Note.fromMap(row)).toList();
   }
   
   

}