import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/features/add_note/add_note_page.dart';
import 'package:note_flow/app/features/add_note/cubit/add_note_cubit.dart';

class SaveTaskButton extends StatelessWidget {
  const SaveTaskButton({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.widget,
    required this.isPinned,
    required this.noteColor,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final AddNotePage widget;
  final bool isPinned;
  final Color noteColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 30),
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
              color: noteColor.value.toRadixString(16),
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
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
