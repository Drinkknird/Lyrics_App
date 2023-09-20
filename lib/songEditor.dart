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


  @override
  void dispose() {
    songNameController.dispose();
    chordsController.dispose();
    lyricsController.dispose();
    super.dispose();
  }

  void addChordsAndLyricsLine() {
    setState(() {
      chordsList.add(chordsController.text);
      lyricsList.add(lyricsController.text);
      chordsController.clear();
      lyricsController.clear();
    });
  }

  void editChordsAndLyricsLine(int index) {
    setState(() {
      chordsController.text = chordsList[index];
      lyricsController.text = lyricsList[index];
      chordsList.removeAt(index);
      lyricsList.removeAt(index);
    });
  }

  void deleteChordsAndLyricsLine(int index) {
    setState(() {
      chordsList.removeAt(index);
      lyricsList.removeAt(index);
    });
  }

  void editLyricsLine(int index) {
    setState(() {
      lyricsController.text = lyricsList[index];
      lyricsList.removeAt(index);
    });
  }

  void deleteLyricsLine(int index) {
    setState(() {
      lyricsList.removeAt(index);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Song Editor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: songNameController,
              decoration: InputDecoration(
                labelText: 'Song Name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: chordsController,
              decoration: InputDecoration(
                labelText: 'Chords',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: lyricsController,
              decoration: InputDecoration(
                labelText: 'Lyrics',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addChordsAndLyricsLine,
              child: Text('Add Chords and Lyrics Line'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 47, 224, 177),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.black87,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
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
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => deleteChordsAndLyricsLine(index),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lyrics: ${lyricsList[index]}'),
                          SizedBox(),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String songName = songNameController.text;
                List<String> chords = List.from(chordsList);
                List<String> lyrics = List.from(lyricsList);
                Song newSong =
                    Song(name: songName, chords: chords, lyrics: lyrics);
                Navigator.pop(context, newSong);
              },
              child: Text('Save Song'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 225, 9, 9),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(221, 250, 250, 250),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}