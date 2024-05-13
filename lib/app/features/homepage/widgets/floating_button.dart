import 'package:flutter/material.dart';
import 'package:note_flow/app/core/constant.dart';

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
            color: Colors.white,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: kFloating,
        onPressed: () {},
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
