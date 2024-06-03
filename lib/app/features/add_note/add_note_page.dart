import 'package:flutter/material.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/domain/database/db_helper.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/features/add_note/cubit/add_note_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({
    super.key,
    this.noteModel,
  });

  final NoteModel? noteModel;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  bool isPinned = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    if (widget.noteModel != null) {
      titleController.text = widget.noteModel!.title;
      descriptionController.text = widget.noteModel!.description;
      isPinned = widget.noteModel!.pinned == 1;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(DBHelper()),
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          final errorMessage = state.errorMessage ?? 'Unknown error';

          if (state.status == Status.success) {
            context.read<HomeCubit>().start();
            Navigator.of(context).pop();
          }
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              final FocusScopeNode currentScope = FocusScope.of(context);
              if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  widget.noteModel == null ? 'Add a note' : 'Edit note',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isPinned = !isPinned;
                      });
                    },
                  ),
                ],
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: kGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 40, top: 15),
                        child: Center(
                          child: Text(
                            'What\'s on your mind?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: titleController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            labelText: 'Note title',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.75,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'Type note here',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          labelText: 'Note description',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {},
                      ),
                      const Expanded(flex: 3, child: Spacer()),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final title = titleController.text;
                              final description = descriptionController.text;

                              if (title.isEmpty || description.isEmpty) {
                                return;
                              }

                              final NoteModel model = NoteModel(
                                id: widget.noteModel?.id,
                                title: title,
                                description: description,
                                pinned: isPinned ? 1 : 0,
                              );

                              context.read<AddNoteCubit>().addOrUpdate(model);
                            },
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                kPrimaryButton,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              widget.noteModel == null ? 'Save' : 'Edit',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
