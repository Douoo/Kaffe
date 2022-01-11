import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart' deferred as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final Future<void> loadedLibrary = await app.loadLibrary();
  runApp(FutureBuilder(
    future: loadedLibrary,
    builder: (context, snapshot) => app.Kaffe(),
  ));
}
