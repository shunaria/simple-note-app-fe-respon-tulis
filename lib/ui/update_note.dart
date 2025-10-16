import 'package:flutter/material.dart';
import '../models/note.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Note note;
  const UpdateNoteScreen({required this.note, Key? key}) : super(key: key);

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = NoteBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 10.0),
          TextField(controller: _contentController, decoration: const InputDecoration(labelText: 'Content'), maxLines: null),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              bloc.addEvent(UpdateNoteEvent(widget.note.id, _titleController.text, _contentController.text));
              Navigator.pop(context);
            },
            child: const Text('Save'),
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
