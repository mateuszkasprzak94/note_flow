import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.tagTitle,
    required this.tagType,
    required this.onChanged,
  });

  final String tagTitle;
  final bool tagType;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.label_outline,
          color: Colors.white,
          size: dw * 0.075,
        ),
        Text(
          tagTitle,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: dw * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Checkbox(
          checkColor: Colors.white,
          activeColor: const Color(0xFF016975),
          value: tagType,
          onChanged: onChanged,
          side: WidgetStateBorderSide.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const BorderSide(
                  color: Color(0xFF016975),
                  width: 2,
                );
              }
              return const BorderSide(
                color: Colors.white,
                width: 2,
              );
            },
          ),
        ),
      ],
    );
  }
}
