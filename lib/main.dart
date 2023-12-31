import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/cubit/bloc_observer.dart';
import 'package:notesapp/cubit/notes_cubit.dart';
import 'package:notesapp/views/notes_view.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'NotesApp',
          theme: ThemeData(brightness: Brightness.dark),
          home: const NotesView()),
    );
  }
}
