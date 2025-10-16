import 'dart:async';
import '../models/note.dart';

class NoteRepository {
  final List<Note> _notes = [];
  int _nextId = 1;

  Future<List<Note>> fetchNotes() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_notes);
  }

  Future<Note> addNote(String title, String body) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final note = Note(id: _nextId++, title: title, body: body);
    _notes.add(note);
    return note;
  }

  Future<Note> updateNote(int id, String title, String body) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final idx = _notes.indexWhere((n) => n.id == id);
    if (idx == -1) throw Exception('Note not found');
    _notes[idx] = _notes[idx].copyWith(title: title, body: body);
    return _notes[idx];
  }

  Future<void> deleteNotes(List<int> ids) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _notes.removeWhere((n) => ids.contains(n.id));
  }
}
