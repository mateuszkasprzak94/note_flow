import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/features/add_note/add_note_page.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';
import 'package:note_flow/app/features/homepage/widgets/note_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePageBodyWidget extends StatefulWidget {
  const HomePageBodyWidget({
    super.key,
    required this.pinnedNotes,
    required this.otherNotes,
  });

  final List<NoteModel> pinnedNotes;
  final List<NoteModel> otherNotes;

  @override
  State<HomePageBodyWidget> createState() => _HomePageBodyWidgetState();
}

class _HomePageBodyWidgetState extends State<HomePageBodyWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() => setState(() {}));

    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.pinnedNotes.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Pinned',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.pinnedNotes.length,
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      final note = widget.pinnedNotes[index];
                      return NoteWidget(
                        noteModel: note,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddNotePage(
                                noteModel: note,
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Are you sure you want to delete this note?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
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
                      );
                    },
                  ),
                ),
              ],
              if (widget.otherNotes.isNotEmpty && widget.pinnedNotes.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Others',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (widget.otherNotes.isNotEmpty && widget.pinnedNotes.isEmpty)
                const SizedBox(height: 20),
              if (widget.otherNotes.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.otherNotes.length,
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      final note = widget.otherNotes[index];
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
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
