import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/constants.dart';
import 'package:notesapp/cubit/notes_cubit.dart';
import 'package:notesapp/cubit/notes_states.dart';
import 'package:notesapp/widgets/note_item.dart';

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = NotesCubit.get(context);
        return ConditionalBuilder(
          condition:
              (state is! DatabaseGetLoadingState && cubit.notes.isNotEmpty),
          builder: (context) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.notes.length,
              itemBuilder: (context, index) {
                final colorIndex = index % kColors.length;
                return NoteItem(
                  color: kColors[colorIndex],
                  note: cubit.notes[index],
                );
              },
            );
          },
          fallback: (context) {
            return state is DatabaseGetLoadingState
                ? const Center(child: CircularProgressIndicator())
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.grey,
                          size: 70,
                        ),
                        Text('No Notes added',
                            style: TextStyle(
                              fontSize: 18,
                            ))
                      ],
                    ),
                  );
          },
        );
      },
    );
  }
}
