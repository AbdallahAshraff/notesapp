import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/cubit/notes_states.dart';
import 'package:sqflite/sqflite.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitState());

  static NotesCubit get(context) => BlocProvider.of(context);

  Database? database;
  void createDatabase() {
    openDatabase(
      'mynotes.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY , title TEXT , subtitle TEXT)')
            .then((value) {
            emit(DatabaseCreatedState());
          log('Database created');
        }).catchError((error) {
          log(error.toString());
        });
      },
      onOpen: (database) {
        log('Database Opened');
        getTasksfromDB(database);

        emit(DatabaseGetState());
        
      },
    ).then((value) {
      database = value;
    });
    
  }

  Future<void> insertIntoDatabase({
    required String title,
    required String subTitle,
  }) async {
    await database!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO notes(title, subtitle) VALUES("$title", "$subTitle")')
          .then((value) {
        log('$value database inserted successfully');
        emit(DatabaseInsertedState());

        getTasksfromDB(database);
        emit(DatabaseGetState());
      }).catchError((error) {
        log('There was an error ${error.toString()}');
      });
      return null;
    });
  }

  List<Map> notes = [];
  void getTasksfromDB(Database? database) async {
    notes = [];
    emit(DatabaseGetLoadingState());

    return await database!.rawQuery('SELECT * FROM notes').then((value) {
     
      for (var element in value) {
        notes.add(element);
      }
      emit(DatabaseGetState());
    });
  }

  Future<void> updateDB({String? title, String? subTitle, required int id}) async {
    database!
        .rawUpdate('UPDATE notes SET title = ?, subtitle = ? WHERE id = ?', [
      title,
      subTitle,
      id,
    ]).then((value) {
      getTasksfromDB(database);
      emit(DatabaseUpdateState());
    });
  }

  void deleteDB({required int id}) async {
    database!.rawDelete('DELETE FROM notes WHERE id = ?', [id]).then((value) {
      getTasksfromDB(database);
      emit(DatabaseDeleteState());
    });
  }
}
