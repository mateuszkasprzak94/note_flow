import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/domain/database/db_helper.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/features/add_note/cubit/add_note_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/features/add_note/widgets/note_textfield.widget.dart';
import 'package:note_flow/app/features/add_note/widgets/save_task_button_widget.dart';
import 'package:note_flow/app/features/add_note/widgets/title_textfield_widget.dart';
import 'package:note_flow/app/features/add_note/widgets/title_widget.dart';
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
  Color noteColor = Colors.white;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();

    if (widget.noteModel != null) {
      titleController.text = widget.noteModel!.title.trim();
      descriptionController.text = widget.noteModel!.description.trim();
      isPinned = widget.noteModel!.pinned == 1;
      noteColor = _colorFromString(widget.noteModel!.color);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Color _colorFromString(String colorString) {
    final colorInt = int.parse(colorString, radix: 16);
    return Color(colorInt);
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
          final note = widget.noteModel;
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<HomeCubit>().delete(note!);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
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
                      const TitleWidget(),
                      TitleTextFieldWidget(titleController: titleController),
                      NoteTextFormFieldWidget(
                          descriptionController: descriptionController),
                      const Expanded(flex: 2, child: SizedBox()),
                      IconButton(
                        onPressed: () => pickColor(context),
                        icon: Icon(
                          Icons.color_lens_outlined,
                          color: noteColor,
                          size: 30,
                        ),
                      ),
                      SaveTaskButton(
                          titleController: titleController,
                          descriptionController: descriptionController,
                          widget: widget,
                          isPinned: isPinned,
                          noteColor: noteColor),
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

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlockPicker(
                pickerColor: noteColor,
                availableColors: const [
                  Colors.white,
                  Colors.red,
                  Colors.pink,
                  Colors.purple,
                  Colors.deepPurple,
                  Colors.indigo,
                  Colors.blue,
                  Colors.lightBlue,
                  Colors.cyan,
                  Colors.teal,
                  Colors.green,
                  Colors.lightGreen,
                  Colors.lime,
                  Colors.yellow,
                  Colors.amber,
                  Colors.orange,
                  Colors.deepOrange,
                  Colors.brown,
                  Colors.grey,
                  Colors.blueGrey,
                  Colors.black
                ],
                onColorChanged: (color) => setState(() => noteColor = color),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('SELECT'),
              ),
            ],
          ),
        );
      },
    );
  }
}
