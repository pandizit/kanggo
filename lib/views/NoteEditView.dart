import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kanggo/models/NoteModels.dart';

class NoteEditView extends StatefulWidget {
  const NoteEditView({Key? key, required this.catatan}) : super(key: key);
  final NoteModel catatan;
  @override
  State<StatefulWidget> createState() {
    return _NoteEditView();
  }
}

class _NoteEditView extends State<NoteEditView> {
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    judul.text = widget.catatan.judul;
    isi.text = widget.catatan.isi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mode Ubah Catatan',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          TextFormField(
            controller: judul,
            decoration: const InputDecoration(labelText: 'Judul'),
          ),
          TextFormField(
            controller: isi,
            decoration: const InputDecoration(labelText: 'Isi'),
          ),
          const SizedBox(height: 20),
          !loading
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    var data = <String, String>{
                      'judul': judul.text,
                      'isi': isi.text
                    };
                    firebaseFirestore
                        .collection('catatan')
                        .doc(widget.catatan.id)
                        .update(data)
                        .then((value) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Update berhasil !'))),
                              Navigator.pop(context, true)
                            });
                  },
                  child: const Text('Simpan'))
              : const Center(child: CircularProgressIndicator())
        ]),
      ),
    );
  }
}
