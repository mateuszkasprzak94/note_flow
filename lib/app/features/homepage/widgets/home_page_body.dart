import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/features/add_note/add_note_page.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';
import 'package:note_flow/app/features/homepage/widgets/note_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

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
    return Scrollbar(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5) +
                    const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (pinnedNotes.isNotEmpty) ...[
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Pinned',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pinnedNotes.length,
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          final note = pinnedNotes[index];
                          return NoteWidget(
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
                                          context
                                              .read<HomeCubit>()
                                              .delete(note);
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
                          );
                        },
                      ),
                    ],
                    if (otherNotes.isNotEmpty && pinnedNotes.isNotEmpty)
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Others',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (otherNotes.isNotEmpty && pinnedNotes.isEmpty)
                      const SizedBox(height: 20),
                    if (otherNotes.isNotEmpty) ...[
                      StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: otherNotes.length,
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          final note = otherNotes[index];
                          return NoteWidget(
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
                                          context
                                              .read<HomeCubit>()
                                              .delete(note);
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
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
