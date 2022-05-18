import 'package:flutter/material.dart';
import 'package:kanggo/models/NoteModels.dart';

class NoteInfoView extends StatefulWidget {
  const NoteInfoView({Key? key, required this.catatan}) : super(key: key);
  final NoteModel catatan;
  @override
  State<StatefulWidget> createState() {
    return _NoteInfoView();
  }
}

class _NoteInfoView extends State<NoteInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Text(
            widget.catatan.judul,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.catatan.isi,
            textAlign: TextAlign.center,
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
