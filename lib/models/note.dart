class Note {
  final int id;
  String title;
  String body;

  Note({required this.id, required this.title, required this.body});

  Note copyWith({int? id, String? title, String? body}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
