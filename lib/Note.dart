class Note {
  int id;
  String title;
  String content;
  String createdOn;
  String updatedOn;

  static const String TABLE_NAME = "notes";
  static const String COLUMN_ID = "_id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_CONTENT = "content";
  static const String COLUMN_CREATED_ON = "created_on";
  static const String COLUMN_UPDATED_ON = "updated_on";

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    id = map[COLUMN_ID];
    title = map[COLUMN_TITLE];
    content = map[COLUMN_CONTENT];
    createdOn = map[COLUMN_CREATED_ON];
    updatedOn = map[COLUMN_UPDATED_ON];
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map= {
      COLUMN_TITLE: title,
      COLUMN_CONTENT: content,
      COLUMN_CREATED_ON: createdOn,
      COLUMN_UPDATED_ON: updatedOn,
    };
    if(id!=null)
      map[COLUMN_ID]=id;
    return map;
  }
  
}
