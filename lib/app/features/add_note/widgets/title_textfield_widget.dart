import 'package:flutter/material.dart';

class TitleTextFieldWidget extends StatelessWidget {
  const TitleTextFieldWidget({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: titleController,
        maxLines: 1,
        decoration: InputDecoration(
          suffixIcon: titleController.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  onPressed: () {
                    titleController.clear();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
          hintText: 'Title',
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          labelText: 'Title',
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
      ),
    );
  }
}
