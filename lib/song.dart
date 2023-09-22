class Song {
  var _name;
  final List<String> chords;
  final List<String> lyrics;

  Song({required String name, required this.chords, required this.lyrics}) {
    _name = name;
  }

  String get name => _name;

  set name(String newName) {
    _name = newName;
  }
}
