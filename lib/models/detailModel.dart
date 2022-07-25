class Detail {
  String noteID;
  String noteTitle;
  String note;
  DateTime createDateTime;
  DateTime? latestEditDateTime;

  Detail({
    required this.noteID,
    required this.noteTitle,
    required this.note,
    required this.createDateTime,
    required this.latestEditDateTime,
  });

  factory Detail.fromJson(Map<String, dynamic> item) {
    return Detail(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            note: item['noteContent'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime: item['latestEditDateTime'] == null ?
            DateTime.parse(item['createDateTime'])
          :
            DateTime.parse(item['latestEditDateTime']),
          );
  }
}
