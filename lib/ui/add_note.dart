import 'package:flutter/material.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = NoteBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 10.0),
          TextField(controller: _contentController, decoration: const InputDecoration(labelText: 'Content'), maxLines: null),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              bloc.addEvent(AddNoteEvent(_titleController.text, _contentController.text));
              Navigator.pop(context);
            },
            child: const Text('Add Note'),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
