import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 15),
      child: Center(
        child: Text(
          'What\'s on your mind?',
          style: TextStyle(
            color: Colors.white,
            fontSize: dw * 0.070,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
