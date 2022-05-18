import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kanggo/models/NoteModels.dart';

class NoteAddView extends StatefulWidget {
  const NoteAddView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NoteAddView();
  }
}

class _NoteAddView extends State<NoteAddView> {
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Catatan Baru'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              controller: judul,
              decoration: const InputDecoration(labelText: 'Judul'),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              controller: isi,
              decoration: const InputDecoration(labelText: 'Isi'),
            ),
            const SizedBox(
              height: 20,
            ),
            !loading
                ? ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      NoteModel noteModel = NoteModel('', judul.text, isi.text);
                      await firebaseFirestore
                          .collection("catatan")
                          .add(noteModel.map)
                          .then((value) {});
                      Navigator.pop(context, true);
                    },
                    child: const Text('Simpan'),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
