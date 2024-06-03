import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/features/add_note/add_note_page.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';
import 'package:note_flow/app/features/homepage/widgets/note_widget.dart';

class HomePageBodyWidget extends StatelessWidget {
  const HomePageBodyWidget({
    super.key,
    required this.pinnedNotes,
    required this.otherNotes,
  });

  final List<NoteModel> pinnedNotes;
  final List<NoteModel> otherNotes;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (pinnedNotes.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              'Pinned',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ...pinnedNotes.map(
          (note) => NoteWidget(
            noteModel: note,
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNotePage(
                    noteModel: note,
                  ),
                ),
              );
            },
            onLongPress: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                        'Are you sure you want to delete this note?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          context.read<HomeCubit>().delete(note);

                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        if (otherNotes.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              'Others',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ...otherNotes.map(
          (note) => NoteWidget(
            noteModel: note,
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNotePage(
                    noteModel: note,
                  ),
                ),
              );
            },
            onLongPress: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                        'Are you sure you want to delete this note?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          context.read<HomeCubit>().delete(note);

                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
