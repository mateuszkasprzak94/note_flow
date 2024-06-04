import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_flow/app/domain/models/note_model.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel noteModel;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const NoteWidget({
    super.key,
    required this.noteModel,
    required this.onTap,
    required this.onLongPress,
  });

  Color _colorFromString(String colorString) {
    final colorInt = int.parse(colorString, radix: 16);
    return Color(colorInt).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    noteModel.title,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                noteModel.description,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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
