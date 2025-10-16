abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final String title;
  final String body;
  AddNoteEvent(this.title, this.body);
}

class UpdateNoteEvent extends NoteEvent {
  final int id;
  final String title;
  final String body;
  UpdateNoteEvent(this.id, this.title, this.body);
}

class DeleteNotesEvent extends NoteEvent {
  final List<int> ids;
  DeleteNotesEvent(this.ids);
}

class ToggleSelectNoteEvent extends NoteEvent {
  final int id;
  ToggleSelectNoteEvent(this.id);
}

class SelectAllEvent extends NoteEvent {}

class ClearSelectionEvent extends NoteEvent {}
