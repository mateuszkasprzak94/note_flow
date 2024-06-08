import 'package:flutter/material.dart';

class NoteTextFormFieldWidget extends StatelessWidget {
  const NoteTextFormFieldWidget({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: descriptionController,
        maxLines: 5,
        decoration: InputDecoration(
          suffixIcon: descriptionController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  onPressed: () => descriptionController.clear(),
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
          hintText: 'Type note here',
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          labelText: 'Note',
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.75,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
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
    );
  }
}
