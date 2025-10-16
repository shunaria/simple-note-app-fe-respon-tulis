import '../models/note.dart';

class NoteState {
  final List<Note> notes;
  final Set<int> selectedIds;
  final bool isSelectionMode;
  final bool loading;
  final String? error;

  NoteState({
    required this.notes,
    required this.selectedIds,
    required this.isSelectionMode,
    required this.loading,
    this.error,
  });

  NoteState copyWith({
    List<Note>? notes,
    Set<int>? selectedIds,
    bool? isSelectionMode,
    bool? loading,
    String? error,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      selectedIds: selectedIds ?? this.selectedIds,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
