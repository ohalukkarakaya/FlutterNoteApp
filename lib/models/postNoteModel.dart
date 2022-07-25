class PostNote{
  String noteTitle;
  String noteContent;

  PostNote(
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