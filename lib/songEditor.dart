import 'package:flutter/material.dart';
import 'song.dart';

class SongEditorPage extends StatefulWidget {
  final List<Song> songs;
  SongEditorPage({required this.songs});
  @override
  _SongEditorPageState createState() => _SongEditorPageState();
}

class _SongEditorPageState extends State<SongEditorPage> {
  final TextEditingController songNameController = TextEditingController();
  final TextEditingController chordsController = TextEditingController();
  final TextEditingController lyricsController = TextEditingController();
  List<String> chordsList = [];
  List<String> lyricsList = [];

  bool isSaveButtonEnabled = false;

  @override
  void dispose() {
    songNameController.dispose();
    chordsController.dispose();
    lyricsController.dispose();
    super.dispose();
  }

  void addChordsAndLyricsLine() {
    if (chordsController.text.isNotEmpty || lyricsController.text.isNotEmpty) {
      setState(() {
        chordsList.add(chordsController.text);
        lyricsList.add(lyricsController.text);
        chordsController.clear();
        lyricsController.clear();
        validateFields();
      });
    }
  }

  void editChordsAndLyricsLine(int index) {
    setState(() {
      chordsController.text = chordsList[index];
      lyricsController.text = lyricsList[index];
      chordsList.removeAt(index);
      lyricsList.removeAt(index);
      validateFields();
    });
  }

  void deleteChordsAndLyricsLine(int index) {
    setState(() {
      chordsList.removeAt(index);
      lyricsList.removeAt(index);
      validateFields();
    });
  }

  void editLyricsLine(int index) {
    setState(() {
      lyricsController.text = lyricsList[index];
      lyricsList.removeAt(index);
      validateFields();
    });
  }

  void deleteLyricsLine(int index) {
    setState(() {
      lyricsList.removeAt(index);
      validateFields();
    });
  }

  void validateFields() {
    setState(() {
      isSaveButtonEnabled =
          songNameController.text.isNotEmpty &&
              (chordsList.isNotEmpty || lyricsList.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Song Editor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.teal.shade200,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: songNameController,
              decoration: const InputDecoration(
                labelText: 'Song Name',
              ),
              onChanged: (value) {
                validateFields();
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: chordsController,
              decoration: const InputDecoration(
                labelText: 'Chords',
              ),
              onChanged: (value) {
                validateFields();
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lyricsController,
              decoration: const InputDecoration(
                labelText: 'Lyrics',
              ),
              onChanged: (value) {
                validateFields();
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addChordsAndLyricsLine,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 47, 224, 177),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.black87,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text('Add Chords and Lyrics Line'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: chordsList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Chord: ${chordsList[index]}'),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => editChordsAndLyricsLine(index),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => deleteChordsAndLyricsLine(index),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lyrics: ${lyricsList[index]}'),
                          SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSaveButtonEnabled
                  ? () {
                      String songName = songNameController.text;
                      List<String> chords = List.from(chordsList);
                      List<String> lyrics = List.from(lyricsList);
                      Song newSong =
                          Song(name: songName, chords: chords, lyrics: lyrics);
                      Navigator.pop(context, newSong);
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 225, 9, 9),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(221, 250, 250, 250),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text('Save Song'),
            ),
          ],
        ),
      ),
    );
  }
}