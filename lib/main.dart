import 'package:flutter/material.dart';
import 'package:note_flow/app/app.dart';
import 'package:note_flow/app/injection_container.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
