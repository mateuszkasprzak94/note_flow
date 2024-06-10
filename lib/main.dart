import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_flow/app/app.dart';
import 'package:note_flow/app/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  configureDependencies();
  runApp(const MyApp());
}
