

class NotesForList {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime? latestEditDateTime;

  NotesForList(
    {
     required this.noteID,
     required this.noteTitle,
     required this.createDateTime,
     required this.latestEditDateTime,
    }
  );

  factory NotesForList.fromJson(Map<String, dynamic> item) {
    return NotesForList(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime: item['latestDateTime'] == null ?
            DateTime.parse(item['createDateTime'])
          :
            DateTime.parse(item['latestDateTime']),
          );
  }
}