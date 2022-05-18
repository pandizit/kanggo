import 'package:flutter/material.dart';
import 'package:kanggo/views/NoteView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const NoteView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
