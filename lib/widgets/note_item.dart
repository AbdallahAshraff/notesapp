// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:notesapp/cubit/notes_cubit.dart';
import 'package:notesapp/views/edit_note.dart';
import 'package:notesapp/widgets/nav.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    Key? key,
    required this.note,
    required this.color,
  }) : super(key: key);
  final Map note;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToNextScreen(
            context,
            EditNoteScreen(
              title: note['title'],
              subtitle: note['subtitle'],
              id: note['id'],

            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.22,
          padding: const EdgeInsets.only(top: 22, bottom: 24, left: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(note['title'],
                    style: const TextStyle(color: Colors.black, fontSize: 22)),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  note['subtitle'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.4), fontSize: 18),
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    NotesCubit.get(context).deleteDB(id: note['id']);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 32,
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
