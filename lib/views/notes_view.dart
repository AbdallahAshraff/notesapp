import 'package:flutter/material.dart';
import 'package:notesapp/cubit/notes_cubit.dart';
import 'package:notesapp/widgets/custom_button.dart';
import 'package:notesapp/widgets/default_form_field.dart';
import 'package:notesapp/widgets/note_builder.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    var titlecontroller = TextEditingController();
    var subTitlecontroller = TextEditingController();
    var cubit = NotesCubit.get(context);
    var formkey = GlobalKey<FormState>();
   
    
        return Scaffold(
            appBar: AppBar(
              title: const Text('Notes'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xffA491D3),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: formkey,
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
                                // prefix: Icons.details,
                                //contentPadding: EdgeInsets.symmetric(vertical: 50),
                                maxlines: 6,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field is required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButon(
                                  //isLoading: isLoading,
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                    //  isLoading = true;
                                      cubit
                                          .insertIntoDatabase(
                                              title: titlecontroller.text,
                                              subTitle: subTitlecontroller.text)
                                          .then((value) {
                                        Navigator.pop(context);
                                        titlecontroller.text = '';
                                        subTitlecontroller.text = '';
                                      });
                                    }
                                    //isLoading = false;
                                  },
                                  text: 'Add Note')
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            body: const NotesBuilder()
            );
      
    
  }
}
