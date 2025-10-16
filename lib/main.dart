import 'package:flutter/material.dart';
import 'bloc/note_bloc.dart';
import 'repository/note_repository.dart';
import 'ui/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NoteBloc bloc;

  @override
  void initState() {
    super.initState();
    final repo = NoteRepository();
    bloc = NoteBloc(repo);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NoteBlocProvider(
      bloc: bloc,
      child: MaterialApp(
        title: 'Note Taking App (BLoC)',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: NoteList(),
      ),
    );
  }
}
