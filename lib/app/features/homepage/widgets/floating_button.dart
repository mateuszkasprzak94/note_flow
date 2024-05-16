import 'package:flutter/material.dart';
import 'package:note_flow/app/core/constant.dart';
import 'package:note_flow/app/features/add_note/add_note_page.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: kPrimaryButton,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: kPrimaryButton,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddNotePage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(0.5, 1),
            )
          ],
        ),
      ),
    );
  }
}
