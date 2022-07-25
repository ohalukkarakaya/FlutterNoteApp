class UpdateNote{
  String noteTitle;
  String noteContent;

  UpdateNote(
    {
      required this.noteTitle,
      required this.noteContent,
    }
  );

  Map<String, dynamic> toJson() {
    return {
      "noteTitle" : noteTitle,
      "noteContent" : noteContent
    };
  }
}