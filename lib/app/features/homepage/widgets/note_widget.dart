import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_flow/app/core/highlight_widget.dart';
import 'package:note_flow/app/domain/models/note_model.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel noteModel;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final String searchTerm;

  const NoteWidget({
    super.key,
    required this.noteModel,
    required this.onTap,
    required this.onLongPress,
    this.searchTerm = '',
  });

  Color _colorFromString(String colorString) {
    final colorInt = int.parse(colorString, radix: 16);
    return Color(colorInt).withOpacity(1.0);
  }

  List<String> _getTags() {
    final tags = <String>[];
    if (noteModel.inspirationTag) tags.add('Inspiration');
    if (noteModel.personalTag) tags.add('Personal');
    if (noteModel.workTag) tags.add('Work');
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;

    final titleStyle = GoogleFonts.lato(
      color: Colors.black,
      fontSize: dw * 0.051,
      fontWeight: FontWeight.w800,
    );
    final descriptionStyle = TextStyle(
      color: Colors.black,
      fontSize: dw * 0.038,
      fontWeight: FontWeight.w400,
    );
    final highlightedStyle = titleStyle.copyWith(color: Colors.red);
    final tags = _getTags();

    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Card(
        color: _colorFromString(noteModel.color),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (noteModel.title.isNotEmpty)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RichText(
                      text: highlightOccurrences(noteModel.title, searchTerm,
                          titleStyle, highlightedStyle),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              RichText(
                text: highlightOccurrences(noteModel.description, searchTerm,
                    descriptionStyle, highlightedStyle),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              if (tags.isNotEmpty)
                Wrap(
                  spacing: 5,
                  runSpacing: 1,
                  children: tags.map(
                    (tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
