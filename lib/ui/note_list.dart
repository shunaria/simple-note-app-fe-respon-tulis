import 'package:flutter/material.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import 'note_detail.dart';
import 'add_note.dart';

class NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = NoteBlocProvider.of(context);

    return StreamBuilder<NoteState>(
      stream: bloc.stream,
      initialData: bloc.currentState,
      builder: (context, snapshot) {
        final state = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Note List'),
            actions: [
              if (!state.isSelectionMode)
                IconButton(
                  icon: const Icon(Icons.select_all),
                  onPressed: () => bloc.addEvent(SelectAllEvent()),
                ),
              if (state.isSelectionMode)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => bloc.addEvent(DeleteNotesEvent(state.selectedIds.toList())),
                ),
            ],
          ),
          body: state.loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.body),
                      onTap: () {
                        if (state.isSelectionMode) {
                          bloc.addEvent(ToggleSelectNoteEvent(note.id));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => NoteDetail(note: note)));
                        }
                      },
                      leading: state.isSelectionMode
                          ? Checkbox(
                              value: state.selectedIds.contains(note.id),
                              onChanged: (v) => bloc.addEvent(ToggleSelectNoteEvent(note.id)),
                            )
                          : null,
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote())),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
