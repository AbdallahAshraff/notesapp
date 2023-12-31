// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:notesapp/cubit/notes_cubit.dart';
import 'package:notesapp/cubit/notes_states.dart';
import 'package:notesapp/widgets/custom_button.dart';
import 'package:notesapp/widgets/default_form_field.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.id,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final int id;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    var titlecontroller = TextEditingController();
    var subTitlecontroller = TextEditingController();
    titlecontroller.text = title;
    subTitlecontroller.text = subtitle;
    var cubit = NotesCubit.get(context);
    GlobalKey<FormState> formkey = GlobalKey();
    return BlocConsumer<NotesCubit, NotesStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: formkey,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Edit Note'),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  // height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DefaultFormField(
                          controller: titlecontroller,
                          hintText: 'Title',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is required';
                            } else {
                              return null;
                            }
                          },

                          // prefix: Icons.title,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DefaultFormField(
                          controller: subTitlecontroller,
                          hintText: 'Subtitle',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is required';
                            } else {
                              return null;
                            }
                          },

                          // prefix: Icons.details,
                          //contentPadding: EdgeInsets.symmetric(vertical: 50),
                          maxlines: 6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButon(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                isLoading = true;
                                cubit
                                    .updateDB(
                                        id: id,
                                        title: titlecontroller.text,
                                        subTitle: subTitlecontroller.text)
                                    .then((value) {
                                  isLoading = false;
                                  Navigator.pop(context);
                                });
                              }
                            },
                            text: 'Edit Note')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
