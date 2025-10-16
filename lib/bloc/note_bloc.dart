import 'dart:async';
import 'package:flutter/widgets.dart';
import '../repository/note_repository.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc {
  final NoteRepository _repo;

  late NoteState _state;
  final _stateController = StreamController<NoteState>.broadcast();
  final _eventController = StreamController<NoteEvent>();

  Stream<NoteState> get stream => _stateController.stream;
  NoteState get currentState => _state;

  NoteBloc(this._repo) {
    _state = NoteState(notes: [], selectedIds: <int>{}, isSelectionMode: false, loading: false);
    _eventController.stream.listen(_mapEventToState);
    addEvent(LoadNotes());
  }

  void addEvent(NoteEvent event) => _eventController.sink.add(event);

  Future<void> _mapEventToState(NoteEvent event) async {
    if (event is LoadNotes) {
      _emit(_state.copyWith(loading: true, error: null));
      try {
        final notes = await _repo.fetchNotes();
        _emit(_state.copyWith(notes: notes, loading: false));
      } catch (e) {
        _emit(_state.copyWith(loading: false, error: e.toString()));
      }
    } else if (event is AddNoteEvent) {
      _emit(_state.copyWith(loading: true, error: null));
      try {
        await _repo.addNote(event.title, event.body);
        final notes = await _repo.fetchNotes();
        _emit(_state.copyWith(notes: notes, loading: false));
      } catch (e) {
        _emit(_state.copyWith(loading: false, error: e.toString()));
      }
    } else if (event is UpdateNoteEvent) {
      _emit(_state.copyWith(loading: true, error: null));
      try {
        await _repo.updateNote(event.id, event.title, event.body);
        final notes = await _repo.fetchNotes();
        _emit(_state.copyWith(notes: notes, loading: false));
      } catch (e) {
        _emit(_state.copyWith(loading: false, error: e.toString()));
      }
    } else if (event is DeleteNotesEvent) {
      _emit(_state.copyWith(loading: true, error: null));
      try {
        await _repo.deleteNotes(event.ids);
        final notes = await _repo.fetchNotes();
        _emit(_state.copyWith(notes: notes, selectedIds: <int>{}, isSelectionMode: false, loading: false));
      } catch (e) {
        _emit(_state.copyWith(loading: false, error: e.toString()));
      }
    } else if (event is ToggleSelectNoteEvent) {
      final selected = Set<int>.from(_state.selectedIds);
      if (selected.contains(event.id)) selected.remove(event.id);
      else selected.add(event.id);
      _emit(_state.copyWith(selectedIds: selected, isSelectionMode: selected.isNotEmpty));
    } else if (event is SelectAllEvent) {
      final ids = _state.notes.map((n) => n.id).toSet();
      _emit(_state.copyWith(selectedIds: ids, isSelectionMode: true));
    } else if (event is ClearSelectionEvent) {
      _emit(_state.copyWith(selectedIds: <int>{}, isSelectionMode: false));
    }
  }

  void _emit(NoteState s) {
    _state = s;
    if (!_stateController.isClosed) _stateController.sink.add(_state);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}

class NoteBlocProvider extends InheritedWidget {
  final NoteBloc bloc;
  const NoteBlocProvider({required Widget child, required this.bloc, Key? key}) : super(key: key, child: child);

  static NoteBloc of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<NoteBlocProvider>();
    assert(provider != null, 'No NoteBlocProvider found in context');
    return provider!.bloc;
  }

  @override
  bool updateShouldNotify(covariant NoteBlocProvider oldWidget) => oldWidget.bloc != bloc;
}
