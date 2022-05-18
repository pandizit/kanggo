import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kanggo/firebase_options.dart';
import 'package:kanggo/models/NoteModels.dart';
import 'package:kanggo/views/NoteAddView.dart';
import 'package:kanggo/views/NoteEditView.dart';
import 'package:kanggo/views/NoteInfoView.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NoteView();
  }
}

class _NoteView extends State<NoteView> {
  List<NoteModel> daftar = [];
  late FirebaseFirestore firebaseFirestore;
  bool loading = false;

  void fill() {
    daftar = [];
    setState(() {
      loading = true;
    });

    firebaseFirestore.collection('catatan').get().then((value) {
      var json = value.docs;
      for (var a = 0; a < json.length; a++) {
        var data = NoteModel(
            json[a].id, json[a].data()['judul'], json[a].data()['isi']);
        setState(() {
          daftar.add(data);
        });
      }

      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    firebaseFirestore = FirebaseFirestore.instance;
    fill();
  }

  Future onrefresh() {
    fill();
    return Future.delayed(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplikasi Note'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: onrefresh,
        child: !loading
            ? ListView.builder(
                itemCount: daftar.length,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NoteInfoView(catatan: daftar[index])));
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Hapus Item ini?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        firebaseFirestore
                                            .collection('catatan')
                                            .doc(daftar[index].id)
                                            .delete()
                                            .then((value) {
                                          setState(() {
                                            daftar.removeAt(index);
                                          });
                                        });
                                      },
                                      child: Text('Ya')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Tidak'))
                                ],
                              );
                            });
                      },
                      leading: Icon(Icons.book,
                          color: Theme.of(context).primaryColor),
                      title: Text(
                        daftar[index].judul,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(daftar[index].isi),
                      trailing: GestureDetector(
                        onTap: () async {
                          var reload = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoteEditView(catatan: daftar[index])));
                          if (reload != null) {
                            fill();
                          }
                        },
                        child: Icon(Icons.edit_note),
                      ),
                    ),
                    Divider()
                  ]);
                }))
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var reload = await Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const NoteAddView())));
          if (reload != null) {
            onrefresh();
          }
        },
      ),
    );
    ;
  }
}
