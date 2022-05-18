class NoteModel {
  late String id;
  late String judul;
  late String isi;
  late Map<String, String> map;

  NoteModel(id, judul, isi) {
    this.id = id;
    this.judul = judul;
    this.isi = isi;
    map = <String, String>{'judul': judul, 'isi': isi};
  }
}
