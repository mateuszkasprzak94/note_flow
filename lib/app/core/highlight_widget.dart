import 'package:flutter/material.dart';

TextSpan highlightOccurrences(
  String text,
  String query,
  TextStyle normalStyle,
  TextStyle highlightedStyle,
) {
  if (query.isEmpty) {
    return TextSpan(text: text, style: normalStyle);
  }

  final matches = query.allMatches(text.toLowerCase());
  if (matches.isEmpty) {
    return TextSpan(text: text, style: normalStyle);
  }

  final List<TextSpan> spans = [];
  int lastMatchEnd = 0;

  for (final match in matches) {
    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd, match.start),
        style: normalStyle,
      ));
    }

    spans.add(TextSpan(
      text: text.substring(match.start, match.end),
      style: highlightedStyle,
    ));

    lastMatchEnd = match.end;
  }

  if (lastMatchEnd < text.length) {
    spans.add(TextSpan(
      text: text.substring(lastMatchEnd),
      style: normalStyle,
    ));
  }

  return TextSpan(children: spans);
}
