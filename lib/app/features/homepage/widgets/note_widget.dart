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

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.lato(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    );
    const descriptionStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );
    final highlightedStyle = titleStyle.copyWith(color: Colors.red);

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
            ],
          ),
        ),
      ),
    );
  }
}
