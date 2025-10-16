import 'package:flutter/material.dart';
import '../models/note.dart';
import 'update_note.dart';

class NoteDetail extends StatelessWidget {
  final Note note;
  const NoteDetail({required this.note, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateNoteScreen(note: note)));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(note.title, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10.0),
          Text(note.body),
        ]),
      ),
    );
  }
}
